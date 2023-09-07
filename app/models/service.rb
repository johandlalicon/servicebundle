class Service < ApplicationRecord
  belongs_to :merchant
  belongs_to :category
  has_many :bookings
  
  before_validation :set_default_image_url

  validates :name, :description, :price, :opening_time, :closing_time,  presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :available_days, presence: true
  validate :closing_time_after_opening_time

  private

  def closing_time_after_opening_time
    if opening_time.present? && closing_time.present? && opening_time >= closing_time
      errors.add(:closing_time, "must be after opening time")
    end
  end

  def set_default_image_url
    self.image_url ||= "https://res.cloudinary.com/dgks1y9qz/image/upload/v1693587085/service-bundle/nirgpe1bbhrlcamj7wrg.png" # Replace with your desired default image URL
  end
  
end
