class ChangeAvailableDaysToArrayTypeInServices < ActiveRecord::Migration[7.0]
  def change
    remove_column :services, :available_days
    add_column :services, :available_days, :text, array: true, default: []
  end
end
