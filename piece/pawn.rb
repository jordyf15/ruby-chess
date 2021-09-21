require_relative 'piece'

class Pawn < Piece
  def initialize coor, symbol, owner
    @coor = coor
    @starting_coor = coor
    @symbol = symbol
    @owner = owner
  end

  def possible_moves board
    movements = []
    if @owner == 'white' # white pawn
      movements = [[-2, 0], [-1, 0], [-1, -1], [-1, 1]]
    elsif @owner == "black" # black pawn
      movements = [[2, 0], [1, 0], [1, -1], [1, 1]]
    end
    unless @coor == @starting_coor && board[@coor[:x] + movements[1][0]][@coor[:y] + movements[1][1]][:piece] == nil
      movements.shift
    end
    possible_moves = movements.map {|movement| {x: @coor[:x]+movement[0] ,y: @coor[:y]+movement[1]}}
      .select do |possible_move|
        possible_move[:x] <=7 && possible_move[:x]>=0 && 
        possible_move[:y] <=7 && possible_move[:y] >=0
      end
      .select do |possible_move|
        board[possible_move[:x]][possible_move[:y]][:piece] == nil || 
        board[possible_move[:x]][possible_move[:y]][:piece].owner != owner
      end
      .reject do |possible_move|
        diagonal = board[possible_move[:x]][possible_move[:y]][:piece]
        possible_move[:y] != @coor[:y] && (diagonal == nil || diagonal.owner == @owner)
      end
      .reject do |possible_move|
        vertical = board[possible_move[:x]][possible_move[:y]][:piece]
        possible_move[:x] != @coor[:x] && possible_move[:y] == coor[:y] && vertical != nil
      end
  end
end