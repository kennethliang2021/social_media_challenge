json.extract! social_media_post, :id, :postable_id, :postable_type, :posted_at, :created_at, :updated_at
json.url social_media_post_url(social_media_post, format: :json)
