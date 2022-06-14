require 'colorize'

class Board
  attr_accessor :grid

  def initialize
    @grid = make_board
  end

  def make_board
    Array.new(8) { Array.new(8, '   ') }
  end

  def drawboard
    i = 8
    puts "\n"
    @grid.each do |row|
      j = 0
      print "   #{i} "
      if i.even?
        until j == row.length
          if j.even?
            print row[j].colorize(:background => :blue)
          else
            print row[j].colorize(:background => :red)
          end
          j += 1
        end
      else
        until j == row.length
          if j.even?
            print row[j].colorize(:background => :red)
          else
            print row[j].colorize(:background => :blue)
          end
          j += 1
        end
      end
      puts "\n"
      i -= 1
    end
    puts '      a  b  c  d  e  f  g  h'
    puts "\n"
  end
end
