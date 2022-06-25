require_relative 'piece'

class Bishop < Piece
  attr_accessor :color, :position

  def initialize(color, position)
    super()
    @color = select_color(color)
    @position = position
  end

  def select_color(color)
    color == 'White' ? '♝' : '♗'
  end

  def moves(location, result = [])
    i = 1
    7.times do
      moves = [[i, i], [-i, -i], [-i, i], [i, -i]]
      moves.each do |move|
        x = location[0] + move[0]
        y = location[1] + move[1]
        result << [x, y] if x.between?(0, 7) && y.between?(0, 7)
      end
      i += 1
    end
    result
  end

  # Good enough for now, I want to refactor later
  def path_empty?(board, start, fin)
    x = fin[0] - start[0]
    y = fin[1] - start[1]

    if x.positive? && y.positive?
      until start == [fin[0] - 1, fin[1] - 1]
        return false if board.grid[start[0] += 1][start[1] += 1] != ' '
      end
    elsif x.positive? && y.negative?
      until start == [fin[0] - 1, fin[1] + 1]
        return false if board.grid[start[0] += 1][start[1] -= 1] != ' '
      end
    elsif x.negative? && y.positive?
      until start == [fin[0] + 1, fin[1] - 1]
        return false if board.grid[start[0] -= 1][start[1] += 1] != ' '
      end
    elsif x.negative? && y.negative?
      until start == [fin[0] + 1, fin[1] + 1]
        return false if board.grid[start[0] -= 1][start[1] -= 1] != ' '
      end
    end
    true
  end
end
