require_relative '../util/chess_util'

class Player
  include ChessUtil
  attr_reader :pieces
  def initialize name, pieces
    @name = name
    @pieces = pieces
  end

  def player_move board
    piece = choose_piece
    possible_moves = piece.possible_moves(board)
    p possible_moves.map {|possible_move| coor_display_formatter possible_move} 
  end

  def move_piece available_move_options
    p available_move_options
    print "Please input the coordination you want the piece to move: "
    coor = gets.chomp
    until available_move_options.include? coor
      print "Please input one of the available coordination displayed: "
      coor = gets.chomp
    end
    formatted_coor = coor_converter(coor)
  end

  def choose_piece
    print "Please choose the piece you want to move: "
    coor = gets.chomp
    until valid_coor?(coor) && valid_piece?(coor_converter(coor))
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