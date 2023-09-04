module Mutations
  class AddCategory < BaseMutation
    # Define the return fields
    field :category, Types::CategoryType, null: false
    field :merchant, Types::MerchantType, null: false

    # Define the argument
    argument :category, Types::CategoryInputType, required: true

    def resolve(category:)
      merchant = context[:current_user]
      new_category = Category.new(category.to_h.merge(merchant_id: merchant.id))
      
      if new_category.save
        { category: new_category, merchant: merchant, errors: [] }
      else
        { category: nil, merchant: nil, errors: new_category.errors.full_messages }
      end
    end
  end
end
