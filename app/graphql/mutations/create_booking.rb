module Mutations
  class CreateBooking < BaseMutation
    require 'pry'
    # TODO: define return fields
    field :booking, Types::BookingType, null: true
    
    argument :booking, Types::BookingInputType, required: true

    def resolve(booking:)
      user = context[:current_user]
      
      service = Service.find(booking[:service_id])
      
      merchant = service.merchant_id

      booking = Booking.new(
        user: user,
        service: service,
        merchant_id: merchant,
        appointment_date: booking[:appointment_date]
      )
      
      if booking.save
        {booking: booking}
      else
        raise GraphQL::ExecutionError.new(booking.errors.full_messages.join(", "))
      end



    end
  end
end
