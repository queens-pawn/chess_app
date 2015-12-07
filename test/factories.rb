FactoryGirl.define do

  factory :game do
    name "testGame"
    white_player_id 1
    black_player_id 1
  end

  factory :piece do
    type 'Rook'
    color 'white'
    x_position 0
    y_position 0
    game
  end

end
