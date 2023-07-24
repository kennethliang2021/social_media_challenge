class CreateCustomLists < ActiveRecord::Migration[7.0]
  def change
    create_table :custom_lists do |t|
      t.string :name
      t.references :team, null: false, foreign_key: true

      t.timestamps
    end
  end
end
