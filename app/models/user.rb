class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  has_many :gift_cards
  has_many :api_keys
  
  before_validation :extract_name_from_email

  state_machine initial: :pending do

    state :pending
    state :regular
    state :admin

    event :make_pending do
      transition [:regular, :admin] => :pending
    end

    event :make_regular do
      transition [:pending, :admin] => :regular
    end

    event :make_admin do
      transition [:pending, :regular] => :admin
    end

  end

  private

  def extract_name_from_email
    return unless self.email.present?
    self.name = self.email.match(/(.+)@/)[1] unless self.name.present?
  end

end
