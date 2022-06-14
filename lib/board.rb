require 'colorize'

class Board
  attr_accessor :grid

  def initialize
    @grid = make_board
  end

  def make_board
    Array.new(8) { Array.new(8, ' ') }
  end

  # def drawboard
  #   i = 8
  #   @grid.each do |row|
  #     j = 0
  #     # print "   #{i} "
  #     if i.even?
  #       until j == row.length
  #         if j.even?
  #           print row[j].colorize(:background => :blue)
  #         else
  #           print row[j].colorize(:background => :red)
  #         end
  #         j += 1
  #       end
  #     else
  #       until j == row.length
  #         if j.even?
  #           print row[j].colorize(:background => :red)
  #         else
  #           print row[j].colorize(:background => :blue)
  #         end
  #         j += 1
  #       end
  #     end
  #     puts "\n"
  #     i -= 1
  #   end
  #   # puts '      a  b  c  d  e  f  g  h'
  # end

  # This is working
  def make_row(color1, color2)
    4.times do
      print '       '.colorize(:background => color1)
      print '       '.colorize(:background => color2)
    end
    print "\n"
  end

  # This is working
  def make_row_value(color, value = 'k')
    print "   #{value}   ".colorize(:background => color)
  end

  # Make this less trash
  def make_row_value_with_data(color1, color2, row = 0)
    make_row_value(color1, @grid[row][0])
    make_row_value(color2, @grid[row][1])
    make_row_value(color1, @grid[row][2])
    make_row_value(color2, @grid[row][3])
    make_row_value(color1, @grid[row][4])
    make_row_value(color2, @grid[row][5])
    make_row_value(color1, @grid[row][6])
    make_row_value(color2, @grid[row][7])
    print "\n"
  end

  def make_row_blocks(color1, color2, row)
    make_row(color1, color2)
    make_row_value_with_data(color1, color2, row)
    make_row(color1, color2)
  end

  def drawboard
  end
end
