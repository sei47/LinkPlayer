FactoryBot.define do
  factory :tag do
    name { 'tag_test' }
  end
  factory :second_tag, class: Tag do
    name { 'tag_test2' }
  end
end
