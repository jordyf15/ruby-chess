require_relative 'player'
require '../piece/king'
require '../piece/bishop'
require '../piece/knight'
require '../piece/pawn'
require '../piece/queen'
require '../piece/rook'

class WhitePlayer < Player
  def initialize name
    super name
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
    @pieces = [@king, @queen, @knight1, @knight2, @rook1, @rook2, @bishop1, @bishop2, 
      @pawn1, @pawn2, @pawn3, @pawn4, @pawn5, @pawn6, @pawn7, @pawn8]
  end
end