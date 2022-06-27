FactoryBot.define do
  factory :user do
    name { 'A' }
    email { 'aaaaaa@email.com' }
    password { 'aaaaaa@email.com' }
    password_confirmation { 'aaaaaa@email.com' }
    admin { 'true' }

    after(:build) do |user|
      user.build_message_read(message_read_last: 0, user: user)
    end
  end
  factory :second_user, class: User do
    name { 'B' }
    email { 'bbbbbb@email.com' }
    password { 'bbbbbb@email.com' }
    password_confirmation { 'bbbbbb@email.com' }
    admin { 'false' }

    after(:build) do |user|
      user.build_message_read(message_read_last: 0, user: user)
    end
  end
end
