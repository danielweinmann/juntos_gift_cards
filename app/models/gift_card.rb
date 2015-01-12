class GiftCard < ActiveRecord::Base

  belongs_to :user

  validates_presence_of :user, :code, :value
  validates_uniqueness_of :code
  validates :value, numericality: { only_integer: true }, allow_blank: true

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

end
