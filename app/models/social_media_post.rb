class SocialMediaPost < ApplicationRecord
  belongs_to :social_media_people_identifier
  validates :content, presence: true
  validates :post_url, presence: true

end
