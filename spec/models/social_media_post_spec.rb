
require 'rails_helper'

RSpec.describe SocialMediaPost, :type => :model do
  let(:team) { instance_double(Team, name: 'Internal team') }
  let(:custom_list) { instance_double(CustomList, id: 1, name: 'Internal team list', team: team) }
  let(:custom_list_people) { instance_double(CustomListPerson, first_name: 'John', last_name: 'Doe', custom_list: custom_list) }
  let(:federal_legislator) { instance_double(FederalLegislator, first_name: 'Frederick', last_name: 'Legiman') }

  let(:social_media_type_facebook) { instance_double(SocialMediaType, name: 'Facebook') }
  let(:social_media_type_twitter) { instance_double(SocialMediaType, name: 'Twitter') }

  let(:custom_list_identifier) { instance_double(SocialMediaPeopleIdentifier, identifiable_type: 'CustomListPerson', social_media_type: social_media_type_facebook, identifiable_id: custom_list_people) }
  let(:legislator_identifier) { instance_double(SocialMediaPeopleIdentifier, identifiable_type: 'FederalLegislator', social_media_type: social_media_type_facebook, identifiable_id: federal_legislator) }

  let(:post1) { instance_double(SocialMediaPost, posted_at: DateTime.new(2023, 7, 20, 12, 0, 0), social_media_people_identifier: custom_list_identifier) }
  let(:post2) { instance_double(SocialMediaPost, posted_at: DateTime.new(2023, 7, 21, 12, 0, 0), social_media_people_identifier: legislator_identifier) }
  let(:post3) { instance_double(SocialMediaPost, posted_at: DateTime.new(2023, 7, 22, 12, 0, 0)) }
  let(:post4) { instance_double(SocialMediaPost, posted_at: DateTime.new(2023, 7, 23, 12, 0, 0)) }
  let(:post5) { instance_double(SocialMediaPost, posted_at: DateTime.new(2023, 7, 24, 12, 0, 0)) }


  describe 'associations' do
    it { should belong_to(:social_media_people_identifier) }
  end


  describe 'validations' do
    it { should validate_presence_of(:post_url) }
    it { should validate_presence_of(:content) }
  end

  describe '.between_dates' do
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

  describe '.by_media_type' do
    before do
      allow(SocialMediaPost).to receive(:by_social_media_type).with('Facebook').and_return([post1, post2])
    end

    it 'returns posts with the specified media type' do
      expect(SocialMediaPost.by_social_media_type(social_media_type_facebook.name)).to match_array([post1, post2])
    end
  end

  describe '.by_custom_list' do
    before do
      allow(SocialMediaPost).to receive(:by_custom_list).with(custom_list.id).and_return([post1])
    end

    it 'returns posts with the specified custom list' do
      expect(SocialMediaPost.by_custom_list(custom_list.id)).to match_array([post1])
    end
  end

  describe '.by_identifiable_type' do
    before do
      allow(SocialMediaPost).to receive(:by_identifiable_type).with('CustomListPerson').and_return([post1, post2])
    end

    it 'returns posts with the specified identifiable type' do
      expect(SocialMediaPost.by_identifiable_type('CustomListPerson')).to match_array([post1, post2])
    end
  end
end
