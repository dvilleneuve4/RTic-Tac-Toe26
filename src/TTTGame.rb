load "TTTPlayer.rb"
load "TTTBoard.rb"

class String
  # colorization
  def colorize(color_code)
    "\e[#{color_code}m#{self}\e[0m"
  end

  def red
    colorize(31)
  end

  def green
    colorize(32)
  end

  def yellow
    colorize(33)
  end

  def pink
    colorize(35)
  end
end

class TTTGame 
	attr_accessor :players, :current_player
	attr_reader :game_board
	def initialize(player_names)
		@players = Array.new
		@current_player_idx = 0
		#First we have to decide what the order of play is
		perm_player_names = player_names.permutation.to_a
		rand_number = rand(0..perm_player_names.count - 1)
		new_player_names = perm_player_names[rand_number]
		#we create the new players
		idx_player = 88 #it's the Xs that start (and 88 is capital X)
		already_chosen_list = Array.new
		new_player_names.each do |name|
			already_chosen_list << idx_player

			@players << TTTPlayer.new(name,idx_player)
			if idx_player == 88
				idx_player = 79
			else

				while already_chosen_list.include? idx_player do
					idx_player = rand(65..90) # chose a new number between A and Z
					#puts idx_player
				end

			end
		end
		##initialize the board :
		## 		now it's a little more complex than simple TTT
		## 		since what we're doing is play on a square grid of (nb_player+1) 
		## 		in the end it's going to be handled by the TTTBoard class
		@game_board = TTTBoard.new players.count+1

		@current_player = @players[@current_player_idx]
	end
	#verify if a final state was reached on the game board
	#returns true if it's over
	def final?()
		#puts @game_board
		@game_board.final?
	end
	def congrats_winner()
		if @game_board.winner_value != nil
			winner_symbol = @game_board.winner_value.value
			winner = @players.select { |item| item.symbol == winner_symbol }
			puts "congrats to #{winner[0]} you have won!!!"
		else
			puts "That's a TIE, congrats to everyone!!!"
		end
	end
	def get_move()
		begin
			puts "It is the turn of #{current_player} to play"
			puts "where do yo want to place your #{current_player.symbol} (format must be i,j where i is the column and j the row, both starts at 0):"
			ans = gets.strip
			move_to_record = ans.split(%r{,\s*})
			#puts move_to_record
			#puts move_to_record.count
			if(move_to_record.count != 2)
				raise "the format of the input is wrong"
			end
			i = move_to_record[0].to_i
			#puts i
			j = move_to_record[1].to_i
			#puts j
			record_move(i,j)
		rescue
			puts "an error as occured in your entry, try again".red
		end

		

	end
	def record_move(i,j)
		@game_board.apply_move(@current_player.symbol,i,j)
		if(@current_player_idx >= (@players.count - 1))
			@current_player_idx = 0
		else
			@current_player_idx += 1
		end
		
		@current_player = @players[@current_player_idx]
	end

	def to_s
		str = ""
		i=0
		@game_board.each {|val| 
			if(i > @players.count)
				i = 0
				str += "\n"
			end
			str += "[" + val.to_s + "]"
			i += 1
			
		}
		str.yellow
	end
	
end
	