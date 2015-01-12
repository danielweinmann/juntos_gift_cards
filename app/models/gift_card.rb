class GiftCard < ActiveRecord::Base

  belongs_to :user

  validates_presence_of :user, :code, :value
  validates_uniqueness_of :code
  validates :value, numericality: { only_integer: true }, allow_blank: true

  after_initialize :set_initial_code

  state_machine initial: :pending do

    state :pending
    state :redeemed
    state :invalid

    event :redeem do
      transition [:pending] => :redeemed
    end

    event :invalidate do
      transition [:pending] => :invalid
    end

  end

  private

  def set_initial_code
    self.code = "#{self.user.try(:id)}-#{Time.now.to_i.to_s(36)}-#{(rand * 100).to_i}" unless self.code.present?
  end

end
