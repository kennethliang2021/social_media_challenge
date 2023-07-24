class CreateSocialMediaPeopleIdentifiers < ActiveRecord::Migration[7.0]
  def change
    create_table :social_media_people_identifiers do |t|
      t.string :identifier
      t.references :social_media_type, null: false, foreign_key: true
      t.references :identifiable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
