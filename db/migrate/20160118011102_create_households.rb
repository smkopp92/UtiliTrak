class CreateHouseholds < ActiveRecord::Migration
  def change
    create_table :households do |t|
      t.string :address, null: false
      t.string :city, null: false
      t.string :state, null: false
      t.string :zip, null: false
      t.integer :occupants, default: 1
      t.belongs_to :user, null: false
    end
  end
end
