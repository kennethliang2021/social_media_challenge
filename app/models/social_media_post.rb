class SocialMediaPost < ApplicationRecord
  belongs_to :social_media_people_identifier
  validates :content, presence: true
  validates :post_url, presence: true

  scope :between_dates, ->(start_date, end_date) {
    if start_date.present? && end_date.present?
      where("posted_at >= ? AND posted_at <= ?", start_date.to_date.beginning_of_day, end_date.to_date.end_of_day)
    else
      all
    end
  }

  scope :by_social_media_type, ->(social_media_type) {
    if social_media_type.present?
      joins(social_media_people_identifier: :social_media_type).where("social_media_types.name ilike ?", social_media_type)
    else
      joins(social_media_people_identifier: :social_media_type)
    end
  }

  scope :by_custom_list, ->(custom_list_id) {
    if custom_list_id.present?
      joins(:social_media_people_identifier).where("social_media_people_identifiers.identifiable_id = ?", custom_list_id)
    else
      joins(:social_media_people_identifier)
    end
  }

  scope :by_identifiable_type, ->(identifiable_type) {
    if identifiable_type.present?
      joins(:social_media_people_identifier).where("social_media_people_identifiers.identifiable_type = ?", identifiable_type)
    else
      joins(:social_media_people_identifier)
    end
  }
end
