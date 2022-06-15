require 'colorize'

class Board
  attr_accessor :grid

  def initialize
    @grid = make_board
  end

  def make_board
    Array.new(8) { Array.new(8, ' ') }
  end

  def make_empty_row(color1, color2)
    4.times do
      print '       '.colorize(background: color1)
      print '       '.colorize(background: color2)
    end
    print "\n"
  end

  def make_single_center_row(color, value = 'k')
    print "   #{value}   ".colorize(background: color)
  end

  def make_full_center_row(color1, color2, row = 0)
    i = 0
    j = 1
    4.times do
      make_single_center_row(color1, @grid[row][i])
      make_single_center_row(color2, @grid[row][j])
      i += 2
      j += 2
    end
    print "\n"
  end

  def make_row_squares(color1, color2, row, height)
    print '    '
    make_empty_row(color1, color2)
    print "  #{height} "
    make_full_center_row(color1, color2, row)
    print '    '
    make_empty_row(color1, color2)
  end

  def drawboard
    i = 0
    j = 1
    height1 = 8
    height2 = 7
    4.times do
      make_row_squares(:red, :green, i, height1)
      make_row_squares(:green, :red, j, height2)
      i += 2
      j += 2
      height1 -= 2
      height2 -= 2
    end
    puts '       a      b      c      d      e      f      g      h'
  end
end
