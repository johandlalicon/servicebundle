class AddAvailabilityFieldsToServices < ActiveRecord::Migration[7.0]
  def change
    add_column :services, :available_days, :text
    add_column :services, :opening_time, :time
    add_column :services, :closing_time, :time
  end
end
