require './lib/board'
# rspec spec/board_spec.rb

describe Board do
  subject(:board) { described_class.new }

  describe '#make_board' do
    it 'creates an array with length 8' do
      expect(board.grid.length).to eq(8)
    end

    it 'has each array element as an array of length 8' do
      expect(board.grid[0].length).to eq(8)
    end
  end
end
