# frozen_string_literal: true

module Types
  class BookingType < Types::BaseObject
    field :id, ID, null: false
    field :user_id, ID, null: false
    field :service_id, ID, null: false
    field :merchant_id, ID, null: false
    field :upcoming, Boolean
    field :cancelled, Boolean
    field :completed, Boolean
    field :receipt, ID
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :appointment_date, GraphQL::Types::ISO8601DateTime
    field :service, ServiceType, null: true do
      description "Services offered by this merchant"
    end
    field :merchant, MerchantType, null: true do
      description "Merchant linked to this booking"
    end

    field :user, UserType, null: true do
      description "User linked to this booking"
    end

    def service
      # Use the association to retrieve all services associated with this merchant
      # Replace 'Merchant' and 'Service' with your actual model names
      object.service
    end
    def merchant
      # Use the association to retrieve all services associated with this merchant
      # Replace 'Merchant' and 'Service' with your actual model names
      object.merchant 
    end
    def user
      # Use the association to retrieve all services associated with this merchant
      # Replace 'Merchant' and 'Service' with your actual model names
      object.user 
    end

  end
end
