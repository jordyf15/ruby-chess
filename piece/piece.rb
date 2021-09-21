class Piece
  attr_reader :symbol, :owner, :alive
  attr_accessor :coor
  def initialize coor, symbol, owner
    @coor = coor
    @symbol = symbol
    @owner = owner
    @alive = true
  end

  def die
    @alive = false
  end
end