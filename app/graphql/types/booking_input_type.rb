# frozen_string_literal: true

module Types
  class BookingInputType < Types::BaseInputObject
    argument :service_id, ID, required: true
    argument :appointment_date, GraphQL::Types::ISO8601DateTime, required: true

  end
end
