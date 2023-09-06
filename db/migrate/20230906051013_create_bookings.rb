class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :service, null: false, foreign_key: true
      t.references :merchant, null: false, foreign_key: true
      t.boolean :upcoming
      t.boolean :cancelled
      t.boolean :completed
      t.integer :receipt

      t.timestamps
    end
  end
end
