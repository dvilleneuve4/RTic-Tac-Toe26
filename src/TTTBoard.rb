load "TTTBoardSquare.rb"
class TTTBoard
	include Enumerable
	attr_reader :winner_value
	def initialize(size)
		#this is going to be our starting point the case at 0,0
		@size = size
		@board = Hash.new
		@winner_value = nil
		(@size).times do |i|
			(@size).times do |j|
				@board["#{i},#{j}"] = TTTBoardSquare.new i,j
				#puts  @board["#{i},#{j}"]
			end
		end
	end

	def each
		@board.each_value do |item|
			yield item.value
		end
	end

	def get_square_by_position(i,j)
		@board["#{i},#{j}"]
	end

	def board_is_full?
		isFull = true
		@board.each_value { |square|
			if(square.value.strip.empty?)
				return false
			end
		}
		isFull
	end

	def check_diagonals
		#checking diagonal, so to say, every string that has i == j or  satisfying size-i == j where i == j
		diagonals = Array.new
		diagonals << Array.new
		(@size).times do |i|
			diagonals.last << "#{i},#{i}"
		end
		diagonals << Array.new
		(@size).times do |i|
			diagonals.last << "#{@size-i -1},#{i}"
		end

		diagonals.each { |d| 
			valid_solution = nil
			valid_solution = valid_squares(d) 
			if valid_solution != nil
				@winner_value = valid_solution
				return true
			end
		}
		return false
	end

	def check_lines
		lines = Array.new
		#checking lines
		@size.times do |i|
			lines << Array.new
			@size.times do |j|
			 	lines.last << "#{i},#{j}"
			end

		end

		lines.each { |d| 
			valid_solution = nil
			valid_solution = valid_squares(d) 
			if valid_solution != nil
				@winner_value = valid_solution
				return true
			end
		}
		return false
	end

	def check_rows
		rows = Array.new
		
		
		#checking rows
		@size.times do |i|
			rows << Array.new
			@size.times do |j|
			 	rows.last << "#{j},#{i}"
			end
		end

		rows.each { |d| 
			valid_solution = nil
			valid_solution = valid_squares(d) 
			if valid_solution != nil
				@winner_value = valid_solution
				return true
			end
		}
		return false
	end

	def final?
		board_is_full? || check_diagonals || check_rows || check_lines		
	end

	# checks if all squares provided in array are of the same value
	def valid_squares(list_of_squares)
		#puts "valid_squares"
		squares_to_check = @board.select {|k,v| list_of_squares.include? k}
		
		val_of_squares = squares_to_check.values
		#puts val_of_squares
		filtered_array = val_of_squares.uniq {|item| 
			if(item.value.strip != "" )
				item.value
			else
				item.position
			end

		}
		if filtered_array.count == 1
			#it is valid
			return filtered_array[0]
		end
		nil
	end

	def apply_move(value,i,j)
		if get_square_by_position(i,j).value.strip.empty?
			get_square_by_position(i,j).value=value
		else
			raise "there is already a value in that case"
		end
	end

	def to_s
		str = ""
		@board.each_value {|val| str += val.to_s + "\n"}
		str
	end
end