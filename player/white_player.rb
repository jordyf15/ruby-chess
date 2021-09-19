require_relative 'player'
require_relative '../piece/king'
require_relative '../piece/bishop'
require_relative '../piece/knight'
require_relative '../piece/pawn'
require_relative '../piece/queen'
require_relative '../piece/rook'

class WhitePlayer < Player
  def initialize name
    @king = King.new({x: 3, y: 7}, "\u265B", name)
    @queen = Queen.new({x: 4, y: 7}, "\u265A", name)
    @knight1 = Knight.new({x: 1, y: 7}, "\u265E", name)
    @knight2 = Knight.new({x: 6, y: 7}, "\u265E", name)
    @rook1 = Rook.new({x: 0, y: 7}, "\u265C", name)
    @rook2 = Rook.new({x: 7, y: 7}, "\u265C", name)
    @bishop1 = Bishop.new({x: 2, y: 7}, "\u265D", name)
    @bishop2 = Bishop.new({x: 5, y: 7}, "\u265D", name)
    @pawn1 = Pawn.new({x: 0, y: 6}, "\u265F", name)
    @pawn2 = Pawn.new({x: 1, y: 6}, "\u265F", name)
    @pawn3 = Pawn.new({x: 2, y: 6}, "\u265F", name)
    @pawn4 = Pawn.new({x: 3, y: 6}, "\u265F", name)
    @pawn5 = Pawn.new({x: 4, y: 6}, "\u265F", name)
    @pawn6 = Pawn.new({x: 5, y: 6}, "\u265F", name)
    @pawn7 = Pawn.new({x: 6, y: 6}, "\u265F", name)
    @pawn8 = Pawn.new({x: 7, y: 6}, "\u265F", name)
    pieces = [@king, @queen, @knight1, @knight2, @rook1, @rook2, @bishop1, @bishop2, 
      @pawn1, @pawn2, @pawn3, @pawn4, @pawn5, @pawn6, @pawn7, @pawn8]
    super name, pieces
  end
end