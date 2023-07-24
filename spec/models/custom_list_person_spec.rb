
require 'rails_helper'

RSpec.describe CustomListPerson, :type => :model do

  describe 'associations' do
    it { should belong_to(:custom_list) }
    it { should have_many(:social_media_people_identifiers) }

  end

  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }

  end

end