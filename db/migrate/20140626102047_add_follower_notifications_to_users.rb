class AddFollowerNotificationsToUsers < ActiveRecord::Migration
  
  def change
    add_column :users, :follower_notifications, :boolean, default: true
  end

  def self.down
     remove_column :users, :follower_notifications
  end

end
