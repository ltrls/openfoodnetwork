class StandingOrder < ActiveRecord::Base
  belongs_to :schedule
  belongs_to :customer
  belongs_to :shipping_method, class_name: 'Spree::ShippingMethod'
  belongs_to :payment_method, class_name: 'Spree::PaymentMethod'
  has_many :standing_line_items

  validates :schedule, presence: true
  validates :customer, presence: true
  validates :shipping_method, presence: true
  validates :payment_method, presence: true
  validates :begins_at, presence: true
  validate :ends_at_after_begins_at

 def ends_at_after_begins_at
   if ends_at.present? && ends_at <= begins_at
     errors.add(:ends_at, "must be after begins at")
   end
 end
end
