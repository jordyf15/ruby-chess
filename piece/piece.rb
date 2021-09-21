class Piece
  attr_reader :symbol, :owner
  attr_accessor :coor
  def initialize coor, symbol, owner
    @coor = coor
    @symbol = symbol
    @owner = owner
  end
end