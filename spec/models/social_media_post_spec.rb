
require 'rails_helper'

RSpec.describe SocialMediaPost, :type => :model do

  describe 'associations' do
    it { should belong_to(:social_media_people_identifier) }
  end


  describe 'validations' do
    it { should validate_presence_of(:post_url) }
    it { should validate_presence_of(:content) }
  end

  describe '.between_dates' do
    let(:post1) { instance_double(SocialMediaPost, posted_at: DateTime.new(2023, 7, 20, 12, 0, 0)) }
    let(:post2) { instance_double(SocialMediaPost, posted_at: DateTime.new(2023, 7, 21, 12, 0, 0)) }
    let(:post3) { instance_double(SocialMediaPost, posted_at: DateTime.new(2023, 7, 22, 12, 0, 0)) }
    let(:post4) { instance_double(SocialMediaPost, posted_at: DateTime.new(2023, 7, 23, 12, 0, 0)) }
    let(:post5) { instance_double(SocialMediaPost, posted_at: DateTime.new(2023, 7, 24, 12, 0, 0)) }

    before do
      allow(SocialMediaPost).to receive(:between_dates) { [post2, post3, post4] }
      allow(SocialMediaPost).to receive(:between_dates).with(nil, nil) { [post1, post2, post3, post4, post5] }
      allow(SocialMediaPost).to receive(:between_dates).with(Date.new(2023, 7, 21), nil) { [post2, post3, post4, post5] }
      allow(SocialMediaPost).to receive(:between_dates).with(nil, Date.new(2023, 7, 21)) { [post1, post2] }
    end

    it 'returns posts within the specified date range' do
      start_date = Date.new(2023, 7, 21)
      end_date = Date.new(2023, 7, 23)
      posts_within_range = SocialMediaPost.between_dates(start_date, end_date)

      expect(posts_within_range).to match_array([post2, post3, post4])
    end

    it 'returns all posts when no date range is provided' do
      all_posts = SocialMediaPost.between_dates(nil, nil)

      expect(all_posts).to match_array([post1, post2, post3, post4, post5])
    end

    it 'returns posts with start_date when end_date is not provided' do
      start_date = Date.new(2023, 7, 21)
      posts_with_start_date = SocialMediaPost.between_dates(start_date, nil)

      expect(posts_with_start_date).to match_array([post2, post3, post4, post5])
    end

    it 'returns posts with end_date when start_date is not provided' do
      end_date = Date.new(2023, 7, 21)
      posts_with_end_date = SocialMediaPost.between_dates(nil, end_date)

      expect(posts_with_end_date).to match_array([post1, post2])
    end
  end
end
