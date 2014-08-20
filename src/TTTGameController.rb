#main program
load "TTTGame.rb"

players = Array.new

# puts "What is the name of the first player"
# players << gets.chomp

# puts "What is the name of the second player"
# players << gets.chomp

puts "Enter the name of the players, leave blank line when done"
loop do
	player = gets.chomp
	break if player == ""
	players << player
end

game = TTTGame.new players

while not game.final? do
	puts game
	game.get_move
end

puts game

game.congrats_winner
