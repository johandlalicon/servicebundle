module Types
  class QueryType < Types::BaseObject
    require 'pry'

    field :all_merchants, [MerchantType],  null: true  
    field :all_services, [ServiceType], null: true 
    field :all_bookings, [BookingType], null: true 

    def all_merchants
      merchants = Merchant.includes(:categories).all
    end

    def all_services
      services = Service.all
    end

    def all_bookings
      bookings = Booking.includes(:service, :user).all    
      
    end

    field :find_merchant, MerchantType, null: true do
      description "Find a merchant by ID and get their associated services"
    end
    def find_merchant
      return unless context[:current_user].is_a?(Merchant)
      user = context[:current_user]
      
      merchant = Merchant.includes(:categories, :services, :bookings).find(user.id)
      merchant
    end

    field :user_bookings, [BookingType], null: true do
      description "User bookings"
    end
    
    def user_bookings
      user = context[:current_user]
      bookings = user.bookings.includes(:service, :merchant) 

      bookings
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
