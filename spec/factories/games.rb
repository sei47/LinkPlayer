FactoryBot.define do
  factory :game do
    name { 'test_game' }
    info { 'test_info' }
  end
  factory :second_game, class: Game do
    name { 'test_gameB' }
    info { 'test_infoB' }
  end
end
