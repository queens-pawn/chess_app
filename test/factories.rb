FactoryGirl.define do

  factory :game do
    name "testGame"
    white_player_id 1
    black_player_id 1
  end

  factory :piece do
    type 'Rook'
    color 'white'
    game_id 1
    x_position 0
    y_position 0
    association :game
  end

end
