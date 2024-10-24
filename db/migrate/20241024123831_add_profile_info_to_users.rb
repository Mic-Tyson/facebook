class AddProfileInfoToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :pfp_url, :string
    add_column :users, :username, :string, null: false
    add_column :users, :bio, :string

    add_index :users, :username, unique: true
  end
end
