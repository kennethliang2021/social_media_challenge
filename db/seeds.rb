# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

internal_team = Team.create(name: 'Internal Team')
external_team = Team.create(name: 'External Team ABC')

internal_team_list = CustomList.create(team: internal_team, name: 'Internal team list')
external_team_list =  CustomList.create(team: external_team, name: 'External team list')

custom_list_people_one = CustomListPerson.create(custom_list: internal_team_list, first_name: 'John', last_name: 'Smith')
custom_list_people_two = CustomListPerson.create(custom_list: internal_team_list, first_name: 'Barbie', last_name: 'Smith')

federal_legislator_people_one = FederalLegislator.create(first_name: 'John', last_name: 'Howard')

facebook_media_type = SocialMediaType.first_or_create(name: 'Facebook')
twitter_media_type = SocialMediaType.create(name: 'Twitter')


facebook_identifer_people_one_identifier = custom_list_people_one.social_media_people_identifiers.create(social_media_type: facebook_media_type, identifier: 'A123')
twitter_identifer_people_one_identifier = custom_list_people_one.social_media_people_identifiers.create(social_media_type: twitter_media_type, identifier: 'T123')


facebook_legislator_people_one_identifier  =federal_legislator_people_one.social_media_people_identifiers.create(social_media_type: facebook_media_type, identifier: 'F321')

facebook_identifer_people_one_post = SocialMediaPost.create(social_media_people_identifier: facebook_identifer_people_one_identifier, content: 'hello world', post_url: 'facebook.com/2334', posted_at: Time.zone.now)
twitter_identifer_people_one_post = SocialMediaPost.create(social_media_people_identifier: twitter_identifer_people_one_identifier, content: 'X', post_url: 'twitter.com/2334', posted_at: Time.zone.now )
federal_legislator_people_one_post =  SocialMediaPost.create(social_media_people_identifier: facebook_legislator_people_one_identifier, content: 'Hello law', post_url: 'facebook.com/4321', posted_at: Time.zone.now )