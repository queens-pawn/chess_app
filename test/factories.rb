FactoryGirl.define do

  factory :game do
    name "testGame"
    white_player_id 1
    black_player_id 2
  end

  factory :piece do
    color "white"
    x_position 1
    y_position 1
    game
  end

  factory :pawn do
    type "Pawn"
    color "white"
    x_position 1
    y_position 1
    piece
  end
end
