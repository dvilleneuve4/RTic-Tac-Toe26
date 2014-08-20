load "TTTGame.rb"

game = TTTGame.new ["Player1","Player2"]

game.record_move 0,0
game.record_move 1,1
game.record_move 2,2

test = game.final?
puts test