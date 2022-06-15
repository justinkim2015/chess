require './lib/player'
require './lib/pieces/rook'

describe Player do
  subject(:player) { described_class.new('Player 1', 'White') }
  let(:rook) { double(Rook) }

  before do
    allow(rook).to receive(:color) { 'Black' }
  end

  describe '#make_pieces' do
    it 'makes pieces' do
    end
  end
end