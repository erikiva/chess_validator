class Board
  attr_accessor :grid
  GRID_DIMENSION = 8
  def initialize file
    @grid = Array.new(8) { Array.new(8, nil) }
    line_num=7
    if File.exist?(file)
      File.open(file).each do |line|
        #puts line
          fill_row line.chomp, line_num
          line_num -= 1
        end
      end

      print_grid

      # @grid.each do |row|
      #   row.each do |cell|
      #     print "#{cell} "
      #   end
      #   print "\n"
      # end
      print "#{@grid[0][7]}  #{@grid[0][6]}  #{@grid[0][5]}"
      puts @grid[0][7]
      puts @grid[0][0]
  end

  def print_grid
      puts "Your current grid"
      (0..7).each do |i|
        (0..7).each do |j|
          print "#{@grid[i][j]} "
        end
        print "\n"
      end
  end
  def fill_row row, column
    row.split.each_with_index do |piece, index|
      @grid[column][index] = piece.to_sym unless piece.include? '--'
    end
  end

  def get_coordinates position
    column = position[0].ord - 97
    row = position[1].to_i - 1
    # puts "The position is col:#{column}   row:#{row} "
    return column, row
  end

  def get_piece_at position
    if @grid[position[0]][position[1]]
      piece = PieceMaker.create_piece(@grid[position[0]][position[1]], position)
    end
  end

  def in_range? value
    value.to_i.between?(0, GRID_DIMENSION-1)
  end

  def inside_grid? xy_origin, xy_destination
    in_range?(xy_origin[0]) && in_range?(xy_origin[1]) && in_range?(xy_destination[0]) && in_range?(xy_destination[1])
  end

  def possible? xy_origin, xy_destination
    inside_grid?(xy_origin, xy_destination)
  end

  def free_path? trayectory
    trayectory.reduce(true) do |free, position|
      free = @grid[]
    end
  end

  def legal? origin, destination
    xy_origin = get_coordinates origin
    xy_destination = get_coordinates destination
    piece = get_piece_at xy_origin

    (possible?(xy_origin, xy_destination) && piece.valid?(xy_origin, xy_destination)) if piece
    # if (possible?(xy_origin, xy_destination) && piece.valid?(xy_origin, xy_destination))
    #   if !piece.allows_obstacles
    #     #free_path? piece.trayectory
    #   end
    #end

  end

end
