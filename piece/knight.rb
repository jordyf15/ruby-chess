require_relative 'piece'

class Knight < Piece
  def initialize coor, symbol, owner
    super coor, symbol, owner
    @possible_moves = [[-1, -2], [-2, -1], [-2, 1], [-1,2], [1,-2], [2,-1], [1, 2], [2, 1]]
  end
end