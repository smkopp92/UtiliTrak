class AddBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.belongs_to :household, null: false
      t.integer :amount, null: false
      t.date :date, null: false
      t.string :kind, null: false
    end
  end
end
