class AddDefaultValuesToBookings < ActiveRecord::Migration[7.0]
  def change
    change_column :bookings, :upcoming, :boolean, default: true
    change_column :bookings, :cancelled, :boolean, default: false
    change_column :bookings, :completed, :boolean, default: false
  end
end
