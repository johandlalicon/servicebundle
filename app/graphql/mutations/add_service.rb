module Mutations
  class AddService < BaseMutation
    require 'pry'
    field :category, Types::CategoryType, null: false
    field :service, Types::ServiceType, null: false
    field :merchant, Types::MerchantType, null: false

    # TODO: define argument
    argument :service, Types::ServiceInputType

    def resolve(service:, category_id: nil)
      merchant = context[:current_user]
      
      category = merchant.categories.find_by(id: 1)
      
      new_service = Service.new(service.to_h.merge(category_id: category.id, merchant_id: merchant.id))
      
      if new_service.save
        
        { service: new_service, errors: [] }
      
      else
        { service: nil, errors: new_service.errors.full_messages } 
      end
      {category: category, merchant: merchant, service: service }
    end
    
  end
end
