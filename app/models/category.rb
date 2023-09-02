class Category < ApplicationRecord
  belongs_to :merchant
  has_many :services
end
