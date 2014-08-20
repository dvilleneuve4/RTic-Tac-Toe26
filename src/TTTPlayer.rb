class TTTPlayer 
	attr_accessor :name, :symbol
	def initialize(name,symbol)
		@name = name
		@symbol = symbol.chr
		@symbol_num = symbol
	end
	def <=> (player)
		@symbol_num <=> player.symbol_num
	end
	def to_s
		"Player #{@name} who uses #{@symbol}"
	end

end
