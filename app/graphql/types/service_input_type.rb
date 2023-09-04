# frozen_string_literal: true

module Types
  class ServiceInputType < Types::BaseInputObject
    argument :name, String, required: true
    argument :description, String, required: false
    argument :image_url, String, required: false
    argument :price, Float, required: true
    argument :opening_time, GraphQL::Types::ISO8601DateTime, required: true
    argument :closing_time, GraphQL::Types::ISO8601DateTime, required: true
    argument :available_days, [String], required: false
  end
end
