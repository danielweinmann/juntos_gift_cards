class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  has_many :gift_cards
  
  before_validation :extract_name_from_email

  private

  def extract_name_from_email
    return unless self.email.present?
    self.name = self.email.match(/(.+)@/)[1] unless self.name.present?
  end

end
