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
end
