class Category < ApplicationRecord
  belongs_to :merchant
  has_many :services

  validate :custom_validation

  private

  def custom_validation
    if name.blank? || description.blank? || image_url.blank?
      errors.add(:base, 'Name, description, and image URL cannot be empty')
    end
  end
end
