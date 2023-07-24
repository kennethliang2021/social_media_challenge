class CreateCustomListPeople < ActiveRecord::Migration[7.0]
  def change
    create_table :custom_list_people do |t|
      t.string :first_name
      t.string :last_name
      t.references :custom_list, null: false, foreign_key: true

      t.timestamps
    end
  end
end
