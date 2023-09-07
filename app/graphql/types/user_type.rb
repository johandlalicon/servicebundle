# frozen_string_literal: true

module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :email, String
    field :first_name, String
    field :last_name, String
    field :mobile_number, String
    field :password_digest, String
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :services, [ServiceType], null: true do
      description "User availed services"
    end
    field :bookings, [BookingType], null: true do
      description "User Bookings"
    end

    def services
      # Use the association to retrieve all services associated with this merchant
      # Replace 'Merchant' and 'Service' with your actual model names
      object.services
    end
    def bookings
      # Use the association to retrieve all services associated with this merchant
      # Replace 'Merchant' and 'Service' with your actual model names
      object.bookings
    end
  end
end
