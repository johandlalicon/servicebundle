class Service < ApplicationRecord
  belongs_to :merchant
  belongs_to :category
 
  validates :name, :description, :price, :opening_time, :closing_time, :image_url, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :available_days, presence: true
  validate :closing_time_after_opening_time

  private

  def closing_time_after_opening_time
    if opening_time.present? && closing_time.present? && opening_time >= closing_time
      errors.add(:closing_time, "must be after opening time")
    end
  end
  
end
