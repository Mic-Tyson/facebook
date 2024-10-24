class CreateRequests < ActiveRecord::Migration[7.2]
  def change
    create_table :requests do |t|
      t.references :requester, null: false, foreign_key: { to_table: :users }
      t.references :requested, null: false, foreign_key: { to_table: :users }

      t.integer :status

      t.timestamps
    end

    add_index :requests, [ :requester_id, :requested_id ], unique: :true
    # re-requesting will require separate logic
  end
end
