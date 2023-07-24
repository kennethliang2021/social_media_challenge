class SocialMediaPeopleIdentifier < ApplicationRecord
  belongs_to :social_media_type
  belongs_to :identifiable, polymorphic: true
  has_many :social_media_posts
  validates :identifier, presence: true

end
