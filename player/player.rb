require_relative '../util/chess_util'

class Player
  include ChessUtil
  attr_reader :pieces, :name
  def initialize name, pieces, king
    @name = name
    @pieces = pieces
    @king = king
  end

  def player_move board, enemy_pieces
    remove_dead_piece
    piece = choose_piece(board, enemy_pieces)
    possible_moves = piece.possible_moves(board)
    possible_safe_moves = safe_move(possible_moves, piece, enemy_pieces, board)
    available_move_options = possible_safe_moves.map {|possible_move| coor_display_formatter possible_move}
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

  def choose_piece board, enemy_pieces
    print "Please choose the piece you want to move: "
    coor = gets.chomp
    until valid_coor?(coor) && valid_piece?(coor) && moveable_piece?(coor, board, enemy_pieces)
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

  def moveable_piece? coor, board, enemy_pieces
    return false unless valid_piece?(coor)
    piece = get_player_piece coor
    possible_moves = piece.possible_moves(board)
    possible_safe_moves = safe_move(possible_moves, piece, enemy_pieces, board)
    return true if possible_safe_moves.size > 0
    puts "That piece has no legal moves for now." 
    false
  end

  def remove_dead_piece 
    @pieces = @pieces.reject {|piece| piece.alive == false}
  end

  def king_checked? enemy_pieces, board, alter
    result = enemy_pieces.any? {|enemy_piece| enemy_piece.possible_moves(board).include? @king.coor}
    @king.check = result if alter == true 
    result
  end

  def safe_move possible_moves, piece, enemy_pieces, board
    possible_moves.reject do |possible_move|
      predict_result = predict_after_move(board, piece.coor, possible_move, piece, enemy_pieces)
      predict_enemy_pieces = predict_result[:predict_enemy_pieces]
      predict_board = predict_result[:predict_board]
      king_checked? predict_enemy_pieces, predict_board, false
    end
  end

  def predict_after_move board, before_coor, after_coor, piece, enemy_pieces
    duplicate_board = Marshal.load(Marshal.dump(board))
    duplicate_enemy_pieces = Marshal.load(Marshal.dump(enemy_pieces))
    before_x = before_coor[:x]
    before_y = before_coor[:y]
    after_x = after_coor[:x]
    after_y = after_coor[:y]
    duplicate_board[before_x][before_y][:piece] = nil
    if duplicate_board[after_x][after_y][:piece] != nil
      attacked_piece = duplicate_board[after_x][after_y][:piece]
      duplicate_enemy_pieces.delete(attacked_piece)
    end
    duplicate_board[after_x][after_y][:piece] = piece
    {predict_board: duplicate_board, predict_enemy_pieces: duplicate_enemy_pieces}
  end
end