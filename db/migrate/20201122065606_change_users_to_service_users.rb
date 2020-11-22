class ChangeUsersToServiceUsers < ActiveRecord::Migration[5.0]
  def change
    rename_table :users, :service_users
  end
end
