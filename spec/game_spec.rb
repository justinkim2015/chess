require './lib/game'
require './lib/board'
require './lib/player'
# rspec spec/game_spec.rb

describe Game do
  subject(:game) { described_class.new }

  describe '#move' do
    context 'when a queen is being moved' do
      it 'changes the position of the queen' do
        fin = [3, 3]
        game.board.grid[2][2] = '♛'
        game.turn.pieces[:queen].position = [2, 2]
        expect { game.move([2, 2], fin) }.to change { game.board.grid[3][3] }.from(' ').to('♛')
      end
    end
  end

  describe '#spot_being_attacked?' do
    context 'when spot is being attacked' do
      it 'returns true' do
        spot = [3, 3]
        game.board.grid[2][2] = '♕'
        expect(game.spot_being_attacked?(spot)).to be true
      end
    end

    context 'when spot is not being attacked' do
      it 'returns false' do
        spot = [3, 3]
        game.board.grid[5][2] = '♛'
        expect(game.spot_being_attacked?(spot)).to be false
      end
    end
  end

  describe '#check?' do
    context 'when king is in check' do
      it 'returns true' do
        game.board.grid[0][0] = '♚'
        game.board.grid[1][1] = '♕'
        game.turn.pieces[:king].position = [0, 0]
        expect(game.check?).to be true
      end
    end

    context 'when king isnt in check' do
      it 'returns false' do
        game.board.grid[0][6] = '♚'
        game.turn.pieces[:king].position = [0, 6]
        expect(game.check?).to be false
      end

      it 'returns false' do
        game.board.grid[0][0] = '♚'
        game.turn.pieces[:king].position = [0, 0]
        expect(game.check?).to be false
      end

      it 'returns false' do
        game.board.grid[7][3] = '♚'
        game.board.grid[0][4] = '♕'
        game.player1.pieces[:king].position = [7, 3]
        game.player2.pieces[:queen].position = [0, 4]
        expect(game.check?).to be false
      end
    end

    context 'if moving to a discovered space' do
      it 'returns true' do
        game.board.grid[0][3] = '♚'
        game.board.grid[1][7] = '♕'
        game.turn.pieces[:king].move(game.board, [0, 3], [1, 4])
        expect(game.check?).to be true
      end
    end

    context 'if moving to an undiscovered space' do
      it 'returns false' do
        game.board.grid[0][0] = '♚'
        game.turn.pieces[:king].move(game.board, [0, 0], [0, 1])
        expect(game.check?).to be false
      end
    end
  end

  describe '#checkmate' do
    context 'when king has no escape' do
      it 'returns true' do
        game.board.grid[0][0] = '♚'
        game.board.grid[1][0] = '♟'
        game.board.grid[1][1] = '♟'
        game.board.grid[0][7] = '♕'
        game.turn.pieces[:king].position = [0, 0]
        expect(game.checkmate?).to be true
      end
    end

    context 'when king has an escape' do
      it 'returns false' do
        game.board.grid[0][0] = '♚'
        game.turn.pieces[:king].position = [0, 0]
        expect(game.checkmate?).to be false
      end
    end

    context 'when another piece can save the king' do
      it 'returns false(eating)' do
        game.board.grid[0][0] = '♚'
        game.board.grid[1][0] = '♞'
        game.board.grid[1][1] = '♞'
        game.board.grid[0][2] = '♕'
        game.board.grid[2][2] = '♞'
        game.turn.pieces[:king].position = [0, 0]
        expect(game.checkmate?).to be false
      end

      it 'returns false(blocking)' do
        game.board.grid[7][3] = '♚'
        game.board.grid[3][4] = '♜'
        game.board.grid[0][3] = '♕'
        game.turn.pieces[:king].position = [7, 3]
        expect(game.checkmate?).to be false
      end
    end
  end

  describe '#no_save_eating?' do
    context 'a friendly piece can eat a checking piece' do
      it 'returns false' do
        game.board.grid[0][0] = '♚'
        game.board.grid[0][2] = '♕'
        game.board.grid[4][2] = '♜'
        game.turn.pieces[:king].position = [0, 0]
        expect(game.no_save_eating?).to be false
      end
    end

    context 'a friendly piece cant eat a checking piece' do
      it 'returns true' do
        game.board.grid[7][7] = '♚'
        game.board.grid[7][6] = '♕'
        game.board.grid[3][2] = '♜'
        game.turn.pieces[:king].position = [7, 7]
        expect(game.no_save_eating?).to be true
      end

      it 'returns true' do
        game.board.grid[0][0] = '♚'
        game.board.grid[1][0] = '♞'
        game.board.grid[1][1] = '♞'
        game.board.grid[0][7] = '♕'
        game.turn.pieces[:king].position = [0, 0]
        expect(game.no_save_eating?).to be true
      end
    end
  end

  describe '#king_no_escape?' do
    context 'the king can escape by moving' do
      it 'returns false' do
        game.board.grid[0][0] = '♚'
        game.board.grid[0][2] = '♕'
        game.turn.pieces[:king].position = [0, 0]
        expect(game.king_no_escape?).to be false
      end
    end

    context 'the king cant escape by moving' do
      it 'returns true' do
        game.board.grid[7][7] = '♚'
        game.board.grid[3][5] = '♜'
        game.board.grid[7][0] = '♕'
        game.turn.pieces[:king].position = [7, 7]
        expect(game.no_save_eating?).to be true
      end
    end
  end

  describe '#path_unblockable?' do
    context 'the path can be blocked by an allied piece' do
      it 'returns false' do
        game.board.grid[7][3] = '♚'
        game.board.grid[3][4] = '♜'
        game.board.grid[0][3] = '♕'
        expect(game.path_unblockable?).to be false
      end
    end

    context 'the path cant be blocked by an allied piece' do
      it 'returns true' do
        game.board.grid[7][3] = '♚'
        game.board.grid[4][3] = '♕'
        game.board.grid[0][2] = '♜'
        expect(game.path_unblockable?).to be true
      end
    end
  end

  describe '#remember_spot' do
    context 'When it eats a piece' do
      it 'remembers the piece(white player)' do
        game.board.grid[0][0] = '♕'
        game.turn.taken_pieces = ['♕']
        fin = [0, 0]
        expect(game.remember_spot(fin)).to eq(['♕', '♕'])
      end

      it 'remembers the piece(black player)' do
        game.change_turn
        game.board.grid[0][0] = '♜'
        fin = [0, 0]
        expect(game.remember_spot(fin)).to eq(['♜'])
      end
    end
  end

  describe '#valid_move?' do
    context 'When its valid' do
      it 'returns true' do
        game.board.grid[0][4] = '♜'
        game.turn.pieces[:rook].position = [0, 4]
        start = [0, 4]
        fin = [4, 4]
        expect(game.valid_move?(start, fin)).to be true
      end
    end

    context 'When its invalid' do
      it 'returns false' do
        game.board.grid[0][0] = '♜'
        start = [0, 0]
        fin = [4, 4]
        expect(game.valid_move?(start, fin)).to be false
      end
    end
  end

  describe '#replace_piece?' do
    it 'changes the piece' do
      game.board.grid[0][0] = '♜'
      spot = [0, 0]
      piece = :pawn
      expect { game.replace_piece(spot, piece) }.to change { game.board.grid[0][0] }.from('♜').to('♟')
    end
  end

  describe '#remove_piece_from_array?' do
    it 'removes the piece' do
      game.turn.taken_pieces = ['♜', '♜']
      piece = '♜'
      expect { game.remove_piece_from_array(piece) }.to change { game.turn.taken_pieces }.from( ['♜', '♜']).to( ['♜'])
    end
  end

  describe '#space_clear?' do
    context 'path between king and rook is empty' do
      it 'returns true' do
        rook = [7, 7]
        game.turn.pieces[:king].position = [7, 3]
        game.turn.pieces[:rook].position = [7, 7]
        game.board.grid[7][3] = '♚'
        game.board.grid[7][7] = '♜'
        expect(game.space_clear?(rook)).to be true 
      end
    end

    context 'path between king and rook is not empty' do
      it 'returns false' do
        rook = [7, 7]
        game.turn.pieces[:king].position = [7, 3]
        game.enemy.pieces[:rook].position = [7, 5]
        game.turn.pieces[:rook].position = [7, 7]
        game.board.grid[7][3] = '♚'
        game.board.grid[7][5] = '♖'
        game.board.grid[7][7] = '♜'
        expect(game.space_clear?(rook)).to be false
      end
    end

    describe '#spots_safe?' do
      context 'spots are not being attacked' do
        it 'returns true' do
          rook = [7, 7]
          game.turn.pieces[:king].position = [7, 3]
          game.turn.pieces[:rook].position = [7, 7]
          game.board.grid[7][3] = '♚'
          game.board.grid[7][7] = '♜'
          # game.board.grid[0][5] = '♖'
          expect(game.spots_safe?(rook)).to be true
        end
      end

      context 'path between king and rook is not empty' do
        it 'returns false' do
          rook = [7, 7]
          game.turn.pieces[:king].position = [7, 3]
          game.turn.pieces[:rook].position = [7, 7]
          game.board.grid[7][3] = '♚'
          game.board.grid[7][7] = '♜'
          game.board.grid[0][5] = '♖'
          expect(game.spots_safe?(rook)).to be false
        end
      end
    end
  end

  describe '#castle_left' do
    it 'moves the piece(white)' do
      game.turn.pieces[:king].position = [7, 3]
      game.turn.pieces[:rook].position = [7, 0]
      game.board.grid[7][0] = '♜'
      game.board.grid[7][3] = '♚'
      expect { game.castle_left }.to change { game.board.grid[7][0] }.from('♜').to(' ')
      # expect { game.castling(direction) }.to change { game.board.grid[0][3] }.from('♚').to(' ')
      # expect { game.castling(direction) }.to change { game.board.grid[0][1] }.from(' ').to('♚')
      # expect { game.castling(direction) }.to change { game.board.grid[0][2] }.from(' ').to('♜')
    end

    it 'moves the piece(black)' do
      game.change_turn
      game.turn.pieces[:king].position = [0, 3]
      game.turn.pieces[:rook].position = [0, 7]
      game.board.grid[0][7] = '♜'
      game.board.grid[0][3] = '♚'
      expect { game.castle_left }.to change { game.board.grid[0][7] }.from('♜').to(' ')
      # expect { game.castling(direction) }.to change { game.board.grid[0][3] }.from('♚').to(' ')
      # expect { game.castling(direction) }.to change { game.board.grid[0][1] }.from(' ').to('♚')
      # expect { game.castling(direction) }.to change { game.board.grid[0][2] }.from(' ').to('♜')
    end
  end

  describe '#castle_right' do
    it 'moves the piece(white)' do
      game.turn.pieces[:king].position = [7, 3]
      game.turn.pieces[:rook].position = [7, 7]
      game.board.grid[7][3] = '♚'
      game.board.grid[7][7] = '♜'
      expect { game.castle_right }.to change { game.board.grid[7][7] }.from('♜').to(' ')
      # expect { game.castling(direction) }.to change { game.board.grid[0][3] }.from('♚').to(' ')
      # expect { game.castling(direction) }.to change { game.board.grid[0][1] }.from(' ').to('♚')
      # expect { game.castling(direction) }.to change { game.board.grid[0][2] }.from(' ').to('♜')
    end

    it 'moves the piece(black)' do
      game.change_turn
      game.turn.pieces[:king].position = [0, 3]
      game.turn.pieces[:rook].position = [0, 0]
      game.board.grid[0][3] = '♚'
      game.board.grid[0][0] = '♜'
      # expect { game.castling(direction) }.to change { game.board.grid[0][7] }.from('♜').to(' ')
      # expect { game.castling(direction) }.to change { game.board.grid[0][3] }.from('♚').to(' ')
      # expect { game.castling(direction) }.to change { game.board.grid[0][1] }.from(' ').to('♚')
      expect { game.castle_right }.to change { game.board.grid[0][2] }.from(' ').to('♖')
    end
  end

  describe '#original_positions?' do
    context 'king and rook are in original positions' do
      it 'returns true(white)' do
        game.turn.pieces[:king].position = [7, 3]
        game.turn.pieces[:rook].position = [7, 7]
        game.board.grid[7][3] = '♚'
        game.board.grid[7][7] = '♜'
        expect(game.original_positions?).to be true
      end

      it 'returns true(black)' do
        game.change_turn
        game.turn.pieces[:king].position = [0, 3]
        game.turn.pieces[:rook].position = [0, 0]
        game.board.grid[0][3] = '♚'
        game.board.grid[0][0] = '♜'
        expect(game.original_positions?).to be true
      end
    end

    context 'king and rook are not in original positions' do
      it 'returns false(white)' do
        game.turn.pieces[:king].position = [7, 3]
        game.turn.pieces[:rook].position = [7, 6]
        game.board.grid[7][3] = '♚'
        game.board.grid[7][6] = '♜'
        expect(game.original_positions?).to be false
      end

      it 'returns false(black)' do
        game.change_turn
        game.turn.pieces[:king].position = [0, 5]
        game.turn.pieces[:rook].position = [0, 0]
        game.board.grid[0][5] = '♚'
        game.board.grid[0][0] = '♜'
        expect(game.original_positions?).to be false
      end
    end
  end

  describe '#can_castle_left?' do
    context 'castling conditions are met' do
      it 'returns true(white)' do
        game.turn.pieces[:king].position = [7, 3]
        game.turn.pieces[:rook].position = [7, 0]
        game.board.grid[7][0] = '♜'
        game.board.grid[7][3] = '♚'
        expect(game.can_castle_left?).to be true
      end

      it 'returns true(black)' do
        game.change_turn
        game.turn.pieces[:king].position = [0, 3]
        game.turn.pieces[:rook].position = [0, 7]
        game.board.grid[0][7] = '♖'
        game.board.grid[0][3] = '♔'
        expect(game.can_castle_left?).to be true
      end
    end

    context 'castling conditions arent met' do
      it 'returns false(white/not original position)' do
        game.turn.pieces[:king].position = [7, 3]
        game.turn.pieces[:rook].position = [7, 0]
        game.board.grid[7][0] = '♜'
        game.board.grid[7][2] = '♚'
        expect(game.can_castle_left?).to be false
      end

      it 'returns false(white/enemy attacking)' do
        game.turn.pieces[:king].position = [7, 3]
        game.turn.pieces[:rook].position = [7, 0]
        game.enemy.pieces[:rook].position = [6, 2]
        game.board.grid[7][0] = '♜'
        game.board.grid[6][2] = '♖'
        game.board.grid[7][3] = '♚'
        expect(game.can_castle_left?).to be false
      end

      it 'returns false(white/no space)' do
        game.turn.pieces[:king].position = [7, 3]
        game.turn.pieces[:rook].position = [7, 0]
        game.board.grid[7][0] = '♜'
        game.board.grid[7][1] = '♜'
        game.board.grid[7][3] = '♚'
        expect(game.can_castle_left?).to be false
      end

      it 'returns false(black/no space)' do
        game.change_turn
        game.turn.pieces[:king].position = [0, 3]
        game.turn.pieces[:rook2].position = [0, 7]
        game.board.grid[0][7] = '♖'
        game.board.grid[0][5] = '♖'
        game.board.grid[0][3] = '♔'
        expect(game.can_castle_left?).to be false
      end

      it 'returns false(black/not original position)' do
        game.change_turn
        game.turn.pieces[:king].position = [0, 3]
        game.turn.pieces[:rook2].position = [0, 7]
        game.board.grid[0][7] = '♖'
        game.board.grid[0][2] = '♔'
        expect(game.can_castle_left?).to be false
      end

      it 'returns false(black/space attacked)' do
        game.change_turn
        game.turn.pieces[:king].position = [0, 3]
        game.turn.pieces[:rook2].position = [0, 7]
        game.board.grid[0][7] = '♖'
        game.board.grid[2][5] = '♜'
        game.board.grid[0][3] = '♔'
        expect(game.can_castle_left?).to be false
      end
    end
  end

  describe '#can_castle_right?' do
    context 'castling conditions are met' do
      it 'returns true(white)' do
        game.turn.pieces[:king].position = [7, 3]
        game.turn.pieces[:rook].position = [7, 7]
        game.board.grid[7][3] = '♚'
        game.board.grid[7][7] = '♜'
        expect(game.can_castle_right?).to be true
      end

      it 'returns true(black)' do
        game.change_turn
        game.turn.pieces[:king].position = [0, 3]
        game.turn.pieces[:rook].position = [0, 0]
        game.board.grid[0][3] = '♔'
        game.board.grid[0][0] = '♖'
        expect(game.can_castle_right?).to be true
      end
    end

    context 'castling conditions arent met' do
      it 'returns false(white/not original position)' do
        game.turn.pieces[:king].position = [7, 3]
        game.turn.pieces[:rook].position = [7, 7]
        game.board.grid[7][3] = '♚'
        game.board.grid[7][6] = '♜'
        expect(game.can_castle_left?).to be false
      end

      it 'returns false(white/enemy attacking)' do
        game.turn.pieces[:king].position = [7, 3]
        game.turn.pieces[:rook].position = [7, 7]
        game.board.grid[7][3] = '♚'
        game.board.grid[0][5] = '♖'
        game.board.grid[7][7] = '♜'
        expect(game.can_castle_left?).to be false
      end

      it 'returns false(white/no space)' do
        game.turn.pieces[:king].position = [7, 3]
        game.turn.pieces[:rook].position = [7, 7]
        game.board.grid[7][3] = '♚'
        game.board.grid[7][5] = '♜'
        game.board.grid[7][7] = '♜'
        expect(game.can_castle_left?).to be false
      end

      it 'returns false(black/no space)' do
        game.change_turn
        game.turn.pieces[:king].position = [0, 3]
        game.turn.pieces[:rook2].position = [0, 0]
        game.board.grid[0][3] = '♔'
        game.board.grid[0][1] = '♖'
        game.board.grid[0][0] = '♖'
        expect(game.can_castle_left?).to be false
      end

      it 'returns false(black/not original position)' do
        game.change_turn
        game.turn.pieces[:king].position = [0, 3]
        game.turn.pieces[:rook2].position = [0, 0]
        game.board.grid[0][2] = '♔'
        game.board.grid[0][0] = '♖'
        expect(game.can_castle_left?).to be false
      end

      it 'returns false(black/space attacked)' do
        game.change_turn
        game.turn.pieces[:king].position = [0, 3]
        game.turn.pieces[:rook2].position = [0, 0]
        game.board.grid[0][3] = '♔'
        game.board.grid[7][2] = '♜'
        game.board.grid[0][0] = '♖'
        expect(game.can_castle_left?).to be false
      end
    end
  end
end
