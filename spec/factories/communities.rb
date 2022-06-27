FactoryBot.define do
  factory :community do
    association :game
    name { 'test_community' }
    comment { 'test_comment' }
    create_user_id { '10' }
    icon { nil }

    after(:build) do |community|
      tag = create(:tag)
      community.community_tags << build(:community_tag, community: community, tag: tag)
    end
  end
  factory :second_community, class: Community do
    name { 'test_community' }
    comment { 'test_comment' }
    create_user_id { '10' }
    icon { nil }
  end
end
