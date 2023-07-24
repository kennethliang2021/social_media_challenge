class CustomListPerson < ApplicationRecord
  belongs_to :custom_list
  has_many :social_media_people_identifiers, as: :identifiable
  validates :first_name, presence: true
  validates :last_name, presence: true

end
