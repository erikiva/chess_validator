
class PieceMaker
	def self.create_piece piece, position
		colour = piece[0] == 'b'? 'black':'white'
		case piece[1]
		when 'R'
			Rook.new piece[0]
		when 'N'
			Knight.new piece[0]
		when 'B'
			Bishop.new piece[0]
		when 'Q'
			Queen.new piece[0]
		when 'K'
			King.new piece[0]
		when 'P'
			Pawn.new piece[0], position
		end
	end
end

class Piece 

	attr_reader :colour, :allows_obstacles
	
	def initialize colour
		puts "The colour is #{colour}"
		@colour = colour
		@allows_obstacles = false

	end

	def diagonal_move? x_diff, y_diff
		x_diff.abs == y_diff.abs
	end 

	def horizontal_move? x_diff, y_diff
		x_diff.abs > 0 && y_diff == 0
	end

	def vertical_move? x_diff, y_diff
		y_diff.abs > 0 && x_diff == 0
	end

	def inline_move? x_diff, y_diff
		vertical_move?(x_diff, y_diff) || horizontal_move?(x_diff, y_diff)
	end

	def x_diff origin, destination
		x_diff = destination[0] - origin[0]
		# puts "x_diff :#{x_diff}"
		#return x_diff
	end

	def y_diff origin, destination
		y_diff = destination[1] - origin[1]
		# puts "y_diff :#{y_diff}"
		#return y_diff
	end
end

class Rook < Piece 
	def valid? origin, destination
		inline_move? x_diff(origin, destination), y_diff(origin, destination)
	end 

	def trayectory origin, destination 
	end
end

class Knight < Piece 

	def initialze colour
		super colour
		@allows_obstacles = true
	end

	def valid? origin, destination
		x_diff = x_diff(origin, destination)
		y_diff = y_diff(origin, destination)
		(x_diff.abs == 2 && y_diff.abs == 1) || (x_diff.abs == 1 && y_diff.abs == 2)
	end 
	
	def trayectory origin, destination 
	end
end

class Bishop < Piece
	def valid? origin, destination
		diagonal_move? x_diff(origin, destination), y_diff(origin, destination)
	end 

	def trayectory origin, destination 
		diagonal_move origin, destination
	end
end

class Queen < Piece 
	def valid? origin, destination 
		x_diff = x_diff(origin, destination)
		y_diff = y_diff(origin, destination)
		diagonal_move?(x_diff, y_diff)  || inline_move?(x_diff, y_diff)
	end
end

class King < Piece 
	attr_reader :moves_allowed

	def initialize  colour
		super colour
		@moves_allowed = 1
	end

	def valid_direction? x_diff, y_diff
		diagonal_move?(x_diff, y_diff) || inline_move?(x_diff,y_diff)
	end

	def valid_step? x_diff, y_diff
		(x_diff <= @moves_allowed) && (y_diff <= @moves_allowed)
	end

	def valid? origin, destination
		x_diff = x_diff(origin, destination)
		y_diff = y_diff(origin, destination)
		valid_direction?(x_diff, y_diff) && valid_step?(x_diff, y_diff)
	end

end

class Pawn < Piece
	attr_reader :moves_allowed
	def initialize colour, origin
		super colour
			if (colour == 'w' && origin[1] == 1) || (colour == 'b' && origin[1] == 6)
				@moves_allowed = 2 
			else 
				@moves_allowed = 1
			end
			puts @moves_allowed
	end	

	def moving_forward? x_diff
		(@colour == 'w' && x_diff > 0) || (@colour == 'b' && x_diff < 0)
	end

	def valid? origin, destination
		x_diff = x_diff(origin, destination)
		y_diff = y_diff(origin, destination)
		puts "origin: #{origin} - destination: #{destination}"
		puts "moving forward" if (moving_forward? x_diff) 
		true
	end

	def trayectory origin, destination 
	end
end