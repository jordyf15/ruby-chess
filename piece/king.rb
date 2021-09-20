require_relative 'piece'

class King < Piece
  def initialize coor, symbol, owner
    super coor, symbol, owner
  end

  def possible_moves board
    movements = [[-1, -1], [-1, 0], [-1, 1], [0, 1], [1, 1], [1, 0], [1, -1], [0, -1]]
    possible_moves = movements.map {|movement| {x: @coor[:x]+movement[0] ,y: @coor[:y]+movement[1]}}
    possible_moves = possible_moves.select do |possible_move|
      possible_move[:x] <=7 && possible_move[:x]>=0 && possible_move[:y] <=7 && possible_move[:y] >=0
    end
    possible_moves = possible_moves.select do |possible_move|
      board[possible_move[:x]][possible_move[:y]][:piece] == nil || board[possible_move[:x]][possible_move[:y]][:piece].owner != owner
    end

    possible_moves
  end
end