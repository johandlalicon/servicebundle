# frozen_string_literal: true

module Types
  class ServiceType < Types::BaseObject
    field :id, ID, null: false
    field :name, String
    field :description, String
    field :price, Float
    field :merchant_id, Integer, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :available_days, [String], null: false
    field :opening_time, GraphQL::Types::ISO8601DateTime
    field :closing_time, GraphQL::Types::ISO8601DateTime
    field :image_url, String
    field :bookingCount, Integer, null: true
    field :category, Types::CategoryType, null: true do
      description "Category associated with this service"
    end

    def category
      object.category
    end
    def bookingCount
      object.bookings.count  # Calculate the count of bookings
    end
    
  end
end
