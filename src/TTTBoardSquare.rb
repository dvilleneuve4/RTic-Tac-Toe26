class TTTBoardSquare
	attr_accessor :position, :value
	def initialize(i, j)
		@position = "#{i},#{j}"
		@value = " "
	end

	def <=>(square)
		ret_val = 0

		if(@value == "")
			puts "value is empty"
			ret_val =-1
		elsif (square.value == "")
			puts "square.value is empty"
			ret_val =1
		else
			puts "checking with normal operator"
			ret_val = @value <=> square.value 
		end	
		ret_val
	end

	#alias_method :eql?, :==

	def to_s
		"Tic-Tac-Toe square at position [#{@position}] has a value of [#{value}]"
	end
end