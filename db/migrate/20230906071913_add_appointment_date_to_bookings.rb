class AddAppointmentDateToBookings < ActiveRecord::Migration[7.0]
  def change
    add_column :bookings, :appointment_date, :datetime
  end
end
