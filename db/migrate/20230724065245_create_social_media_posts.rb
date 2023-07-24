class CreateSocialMediaPosts < ActiveRecord::Migration[7.0]
  def change
    create_table :social_media_posts do |t|
      t.datetime :posted_at
      t.references :social_media_people_identifier, null: false, foreign_key: true
      t.text :content
      t.string :post_url

      t.timestamps
    end
  end
end
