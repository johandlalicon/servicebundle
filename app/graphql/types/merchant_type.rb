# frozen_string_literal: true

module Types
  class MerchantType < Types::BaseObject
    field :id, ID, null: false
    field :name, String
    field :email, String
    field :password_digest, String
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :services, [ServiceType], null: true do
      description "Services offered by this merchant"
    end
    field :categories, [CategoryType], null: true do
      description "Service Category"
    end

    def services
      # Use the association to retrieve all services associated with this merchant
      # Replace 'Merchant' and 'Service' with your actual model names
      object.services
    end
    def categories
      # Use the association to retrieve all services associated with this merchant
      # Replace 'Merchant' and 'Service' with your actual model names
      object.categories
    end
  end
end
