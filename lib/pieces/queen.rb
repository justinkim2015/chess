require_relative 'piece'

class Queen < Piece
  attr_accessor :color, :position

  def initialize(color, position)
    super()
    @color = select_color(color)
    @position = position
  end

  def select_color(color)
    color == 'White' ? '♛' : '♕'
  end

  def moves(location, result = [])
    i = 1
    7.times do
      moves = [[i, i], [-i, -i], [-i, i], [i, -i], [i, 0], [-i, 0], [0, i], [0, -i]]
      moves.each do |move|
        x = location[0] + move[0]
        y = location[1] + move[1]
        result << [x, y] if x.between?(0, 7) && y.between?(0, 7)
      end
      i += 1
    end
    result
  end

  def path_empty?(board, spot, piece)
    x = piece[0] - spot[0]
    y = piece[1] - spot[1]

    if x.positive? && y.positive?
      until spot == [piece[0] - 1, piece[1] - 1]
        return false if board.grid[spot[0] += 1][spot[1] += 1] != ' '
      end
    elsif x.positive? && y.negative?
      until spot == [piece[0] - 1, piece[1] + 1]
        return false if board.grid[spot[0] += 1][spot[1] -= 1] != ' '
      end
    elsif x.negative? && y.positive?
      until spot == [piece[0] + 1, piece[1] - 1]
        return false if board.grid[spot[0] -= 1][spot[1] += 1] != ' '
      end
    elsif x.negative? && y.negative?
      until spot == [piece[0] + 1, piece[1] + 1]
        return false if board.grid[spot[0] -= 1][spot[1] -= 1] != ' '
      end
    elsif x.positive?
      until spot == [piece[0] - 1, piece[1]]
        return false if board.grid[spot[0] += 1][spot[1]] != ' '
      end
    elsif x.negative?
      until spot == [piece[0] + 1, piece[1]]
        return false if board.grid[spot[0] -= 1][spot[1]] != ' '
      end
    elsif y.positive?
      until spot == [piece[0], piece[1] - 1]
        return false if board.grid[spot[0]][spot[1] += 1] != ' '
      end
    elsif y.negative?
      until spot == [piece[0], piece[1] + 1]
        return false if board.grid[spot[0]][spot[1] -= 1] != ' '
      end
    end

    true
  end
end
