
require 'rails_helper'

RSpec.describe SocialMediaPost, :type => :model do

  describe 'associations' do
    it { should belong_to(:social_media_people_identifier) }
  end


  describe 'validations' do
    it { should validate_presence_of(:post_url) }
    it { should validate_presence_of(:content) }
  end

end