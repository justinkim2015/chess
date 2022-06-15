require './lib/player'
require './lib/pieces/rook'
require './lib/pieces/king'
require './lib/pieces/bishop'
require './lib/pieces/pawn'
require './lib/pieces/queen'
require './lib/pieces/knight'
# rspec spec/player_spec.rb

describe Player do
  subject(:player) { described_class.new('Player 1', 'White') }
  let(:rook) { double(Rook) }
  let(:queen) { double(Queen) }
  let(:king) { double(King) }
  let(:bishop) { double(Bishop) }
  let(:knight) { double(Knight) }
  let(:pawn) { double(Pawn) }


  before do
    allow(rook).to receive(:color) { 'Black' }
  end

  describe '#make_pieces' do
    xit 'makes pieces' do
      color = 'Black'
      expect(rook).to receive(:new).with(color)
      player.make_pieces
    end
  end
end