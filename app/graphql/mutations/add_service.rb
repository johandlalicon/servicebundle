module Mutations
  class AddService < BaseMutation
    require 'pry'
    
    field :service, Types::ServiceType, null: false
    field :merchant, Types::MerchantType, null: false

    # TODO: define argument
    argument :service, Types::ServiceInputType
    argument :id, ID, required: false
    

    def resolve(service:, id: nil)
      merchant = context[:current_user]

      if id.present?
        existing_service = Service.find_by(id: id, merchant_id: merchant.id)
        if existing_service
          if existing_service.update(service.to_h.merge(merchant_id: merchant.id))
            { service: existing_service, merchant: merchant }
          else
            { service: nil, merchant: merchant, errors: existing_service.errors.full_messages }
          end
        else
          { service: nil, merchant: merchant, errors: ['Service not found'] }
        end
      else
        new_service = Service.new(service.to_h.merge(merchant_id: merchant.id))

        if new_service.save
          { service: new_service, merchant: merchant }
        else
          { service: nil, merchant: merchant, errors: new_service.errors.full_messages }
        end
      end
    end
    
  end
end
