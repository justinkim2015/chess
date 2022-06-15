require './lib/game'
require './lib/board'
require './lib/player'
# rspec spec/game_spec.rb

describe Game do
  subject(:game) { described_class.new }
  let(:player1) { double(Player) }
  let(:player2) { double(Player) }
  let(:board) { double(Board) }

  before do
    allow(player1).to receive(:color) { 'White' }
    allow(player2).to receive(:color) { 'Black' }
    allow(board).to receive(:grid) { Array.new(8) { Array.new(8, ' ') } }
  end

  describe '#set_board' do
    xit 'replaces empty appropriate spot with a piece' do
      piece = '♖'
      expect { game.set_board }.to change { board.grid[0][0] }.from(' ').to(piece)
    end
  end
end
