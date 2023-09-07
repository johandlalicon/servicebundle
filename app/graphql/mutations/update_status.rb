module Mutations
  class UpdateStatus < BaseMutation
    field :booking, Types::BookingType, null: false

    argument :id, ID, required: true
    argument :status, String, required: true

    def resolve(id:, status:)
      booking = Booking.find(id)
      
      # Set upcoming to false unconditionally
      booking.upcoming = false

      case status
      when 'completed'
        booking.completed = true
        booking.cancelled = false
      when 'cancelled'
        booking.completed = false
        booking.cancelled = true
      else
        raise GraphQL::ExecutionError, "Invalid status provided. Use 'completed' or 'cancelled'."
      end

      # Save the changes
      if booking.save
        { booking: booking }
      else
        raise GraphQL::ExecutionError, booking.errors.full_messages.join(", ")
      end
    end
  end
end