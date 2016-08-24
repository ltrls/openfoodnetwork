class StandingOrder < ActiveRecord::Base
  belongs_to :schedule
  belongs_to :customer
  belongs_to :shipping_method, class_name: 'Spree::ShippingMethod'
  belongs_to :payment_method, class_name: 'Spree::PaymentMethod'

  validates :schedule, presence: true
  validates :customer, presence: true
  validates :shipping_method, presence: true
  validates :payment_method, presence: true
  validates :begins_at, presence: true
end
