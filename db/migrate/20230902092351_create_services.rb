class CreateServices < ActiveRecord::Migration[7.0]
  def change
    create_table :services do |t|
      t.string :name
      t.string :category
      t.text :description
      t.decimal :price
      t.references :merchant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
