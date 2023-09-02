class Merchant < ApplicationRecord
    has_secure_password
    validates :email, presence: true, uniqueness: true
    validates :name, presence: true

    has_many :services
    has_many :categories
    
end
