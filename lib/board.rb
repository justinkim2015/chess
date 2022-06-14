require 'colorize'

class Board
  attr_accessor :grid

  def initialize
    @grid = make_board
  end

  def make_board
    Array.new(8) { Array.new(8, '  ') }
  end

  # def drawboard
  #   @grid.each do |row|
  #     print '|'
  #     row.each do |value|
  #       print "#{value} |".colorize( :background => :blue)
  #     end
  #     puts "\n"
  #   end
  # end

  def drawboard
    i = 0
    puts "\n"
    @grid.each do |row|
      j = 0
      print '   '
      if i.even?
        until j == row.length
          if j.even?
            print row[j].colorize(:background => :white)
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
            print row[j].colorize(:background => :white)
          end
          j += 1
        end
      end
      puts "\n"
      i += 1
    end
    puts "\n"
  end
end
