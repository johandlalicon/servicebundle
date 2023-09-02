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

    field :node, Types::NodeType, null: true, description: "Fetches an object given its ID." do
      argument :id, ID, required: true, description: "ID of the object."
    end

    def node(id:)
      context.schema.object_from_id(id, context)
    end

    field :nodes, [Types::NodeType, null: true], null: true, description: "Fetches a list of objects given a list of IDs." do
      argument :ids, [ID], required: true, description: "IDs of the objects."
    end

    def nodes(ids:)
      ids.map { |id| context.schema.object_from_id(id, context) }
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
