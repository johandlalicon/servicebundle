class Service < ApplicationRecord
  belongs_to :merchant
  belongs_to :category
  # serialize :available_days, Array
end
