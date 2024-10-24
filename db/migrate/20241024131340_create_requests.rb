class CreateRequests < ActiveRecord::Migration[7.2]
  def change
    create_table :requests do |t|
      t.references :requester, null: false, foreign_key: true
      t.integer :status

      t.timestamps
    end
  end
end
