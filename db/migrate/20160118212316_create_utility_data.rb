class CreateUtilityData < ActiveRecord::Migration
  def change
    create_table :utilitydata do |t|
      t.string :state, null: false
      t.date :date, null: false
      t.integer :amount, null: false
      t.string :kind, null: false
    end
  end
end
