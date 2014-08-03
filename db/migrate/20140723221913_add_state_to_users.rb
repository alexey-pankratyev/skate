class AddStateToUsers < ActiveRecord::Migration
  def change
    add_column :users, :state, :string
    add_index :users, :state
  end
  
  def self.down
    remove_column :users, :state
  end

end
