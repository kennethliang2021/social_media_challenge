
require 'rails_helper'

RSpec.describe SocialMediaPeopleIdentifier, :type => :model do

  describe 'associations' do
    it { should belong_to(:social_media_type) }
    it { should have_many(:social_media_posts) }
  end


  describe 'validations' do
    it { should validate_presence_of(:identifier) }
  end

end