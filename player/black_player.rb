require_relative 'player'
require '../piece/king'
require '../piece/bishop'
require '../piece/knight'
require '../piece/pawn'
require '../piece/queen'
require '../piece/rook'

class BlackPlayer < Player
  def initialize name
    super name
    @king = King.new({x: 3, y: 0}, "\u2655", name)
    @queen = Queen.new({x: 4, y: 0}, "\u2654", name)
    @knight1 = Knight.new({x: 1, y: 0}, "\u2658", name)
    @knight2 = Knight.new({x: 6, y: 0}, "\u2658", name)
    @rook1 = Rook.new({x: 0, y: 0}, "\u2656", name)
    @rook2 = Rook.new({x: 7, y: 0}, "\u2656", name)
    @bishop1 = Bishop.new({x: 2, y: 0}, "\u2657", name)
    @bishop2 = Bishop.new({x: 5, y: 0}, "\u2657", name)
    @pawn1 = Pawn.new({x: 0, y: 1}, "\u2659", name)
    @pawn2 = Pawn.new({x: 1, y: 1}, "\u2659", name)
    @pawn3 = Pawn.new({x: 2, y: 1}, "\u2659", name)
    @pawn4 = Pawn.new({x: 3, y: 1}, "\u2659", name)
    @pawn5 = Pawn.new({x: 4, y: 1}, "\u2659", name)
    @pawn6 = Pawn.new({x: 5, y: 1}, "\u2659", name)
    @pawn7 = Pawn.new({x: 6, y: 1}, "\u2659", name)
    @pawn8 = Pawn.new({x: 7, y: 1}, "\u2659", name)
  end
end