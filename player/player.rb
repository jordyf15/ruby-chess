require_relative '../util/chess_util'

class Player
  include ChessUtil
  attr_reader :pieces
  def initialize name, pieces
    @name = name
    @pieces = pieces
  end

  def choose_piece
    print "Please choose the piece you want to move: "
    coor = gets.chomp
    until valid_coor?(coor) && valid_piece?(coor_converter(coor))
      p coor
      p coor_converter(coor)
      print "Please input a valid coordination of one of your piece: "
      coor = gets.chomp
    end
    formatted_coor = coor_converter(coor)
    @pieces.select {|piece| piece.coor == formatted_coor}[0]
  end

  def valid_piece? coor
    @pieces.any? {|piece| piece.coor == coor}
  end
end