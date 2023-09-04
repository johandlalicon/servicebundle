module Types
  class QueryType < Types::BaseObject
    require 'pry'
    
    field :find_merchant, MerchantType, null: true do
      description "Find a merchant by ID and get their associated services"
      
    end

    # Resolver for the merchant query
    def find_merchant

      return unless context[:current_user].is_a?(Merchant)
      user = context[:current_user]
      
      merchant = Merchant.includes(:categories, :services).find(user.id)
      
      
      merchant
    end

    

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # TODO: remove me
    field :test_field, String, null: false,
      description: "An example field added by the generator"
    def test_field
      "Hello World!"
    end
  end
end
