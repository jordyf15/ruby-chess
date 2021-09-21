require_relative '../util/chess_util'

class Player
  include ChessUtil
  attr_reader :pieces, :name
  def initialize name, pieces
    @name = name
    @pieces = pieces
  end

  def player_move board
    remove_dead_piece
    piece = choose_piece board
    possible_moves = piece.possible_moves(board)
    available_move_options = possible_moves.map {|possible_move| coor_display_formatter possible_move}
    piece_movement =  move_piece available_move_options
    result = {before: piece.coor, after: piece_movement, piece: piece}
    piece.coor = piece_movement
    result
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

  def choose_piece board
    print "Please choose the piece you want to move: "
    coor = gets.chomp
    until valid_coor?(coor) && valid_piece?(coor) && moveable_piece?(coor, board)
      print "Please input a valid coordination of one of your piece: "
      coor = gets.chomp
    end
    get_player_piece coor
  end

  def valid_piece? coor
    formatted_coor = coor_converter(coor)
    @pieces.any? {|piece| piece.coor == formatted_coor}
  end

  def get_player_piece coor
    formatted_coor = coor_converter(coor)
    @pieces.select {|piece| piece.coor == formatted_coor}[0]
  end

  def moveable_piece? coor, board
    return false unless valid_piece?(coor)
    piece = get_player_piece coor
    return true if piece.possible_moves(board).size > 0
    puts "That piece has no legal moves for now." 
    false
  end

  def remove_dead_piece 
    @pieces = @pieces.reject {|piece| piece.alive == false}
  end
end