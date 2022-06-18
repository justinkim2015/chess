require './lib/pieces/bishop'
require './lib/board'
require './lib/player'
require './lib/pieces/piece'
# rspec spec/rook_spec.rb

describe Rook do
  subject(:rook) { described_class.new('White') }
  subject(:gameboard) { Board.new }
end
