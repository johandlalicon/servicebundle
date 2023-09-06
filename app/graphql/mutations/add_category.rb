module Mutations
  class AddCategory < BaseMutation
    # Define the return fields
    field :category, Types::CategoryType, null: false
    field :merchant, Types::MerchantType, null: false

    # Define the argument
    argument :category, Types::CategoryInputType, required: true
    argument :id, ID, required: false

    def resolve(category:, id: nil)
      merchant = context[:current_user]

      if id.present?
        existing_category = Category.find_by(id: id, merchant_id: merchant.id)
        if existing_category
          if existing_category.update(category.to_h.merge(merchant_id: merchant.id))
            { category: existing_category, merchant: merchant }
          else
            { category: nil, merchant: merchant, errors: existing_category.errors.full_messages }
          end
        else
          { category: nil, merchant: merchant, errors: ['Category not found'] }
        end
      else


      new_category = Category.new(category.to_h.merge(merchant_id: merchant.id))
      
      if new_category.save
        { category: new_category, merchant: merchant, errors: [] }
      else
        { category: nil, merchant: nil, errors: new_category.errors.full_messages }
      end
    end
    end
  end
end
