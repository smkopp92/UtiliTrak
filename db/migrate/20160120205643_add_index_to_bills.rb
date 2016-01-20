class AddIndexToBills < ActiveRecord::Migration
  def up
    add_index :bills, [:kind, :date], unique: true
  end

  def down
    remove_index :bills, [:kind, :date]
  end
end
