require 'pry'
require './Board'
require './Pieces'

class Validator
  attr_accessor :board

  def initialize  board
    @board = board
  end

  def validate_list_file file
    if File.exist?(file)
      File.open(file).each do |line|
          coordinates = line.chomp.split
          print line.chomp + ' -> '
          puts validate_move(@board, coordinates[0], coordinates[1])
        end
      end
  end

  def quick_validate origin, destination
    puts validate_move @board, origin, destination
  end

  def validate_move board, origin, destination
    board.legal?(origin, destination) ? "LEGAL" : "ILLEGAL"
  end

end

validator = Validator.new(Board.new('simple_board.txt'))
validator.validate_list_file('simple_moves.txt')


# validator.quick_validate 'a1', 'c2'
# validator.quick_validate 'a1', 'b3'
# validator.quick_validate 'a1', 'a3'
# validator.quick_validate 'a1', 'b1'
# validator.quick_validate 'a1', 'c3'
# validator.quick_validate 'a1', 'c4'

