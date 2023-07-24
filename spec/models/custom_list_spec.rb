
require 'rails_helper'

RSpec.describe CustomList, :type => :model do

  describe 'associations' do
    it { should belong_to(:team) }
  end


  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

end