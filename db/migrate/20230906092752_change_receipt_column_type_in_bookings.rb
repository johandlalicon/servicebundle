class ChangeReceiptColumnTypeInBookings < ActiveRecord::Migration[7.0]
  def change
    change_column :bookings, :receipt, :bigint
  end
end
