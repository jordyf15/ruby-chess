class Piece
  attr_reader :coor, :symbol, :owner
  def initialize coor, symbol, owner
    @coor = coor
    @symbol = symbol
    @owner = owner
  end
end