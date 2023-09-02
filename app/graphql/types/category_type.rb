# frozen_string_literal: true

module Types
  class CategoryType < Types::BaseObject
    field :id, ID, null: false
    field :name, String
    field :description, String
    field :merchant_id, Integer, null: false
    field :image_url, String
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :services, [ServiceType], null: true do
      description "Services offered by this merchant"
    end
    def services
      # Use the association to retrieve all services associated with this merchant
      # Replace 'Merchant' and 'Service' with your actual model names
      object.services
    end
  end
end
