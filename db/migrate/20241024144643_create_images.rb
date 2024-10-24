class CreateImages < ActiveRecord::Migration[7.2]
  def change
    create_table :images do |t|
      t.references :uploader, null: false, foreign_key: true
      t.references :imageable, polymorphic: true, null: false
      t.string :url
      t.string :caption

      t.timestamps
    end
  end
end
