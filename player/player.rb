require_relative '../util/chess_util'
require_relative '../piece/king'
require_relative '../piece/queen'
require_relative '../piece/bishop'
require_relative '../piece/rook'
require_relative '../piece/knight'
require_relative '../piece/pawn'

class Player
  include ChessUtil
  attr_reader :pieces, :name
  def initialize name
    @name = name
    @king = name == "white" ? King.new({x: 7, y: 3}, "\u265A", name) : King.new({x: 0, y: 3}, "\u2654", name)
    @queen = name == "white" ? Queen.new({x: 7, y: 4}, "\u265B", name) : Queen.new({x: 0, y: 4}, "\u2655", name)
    @knight1 = name == "white" ? Knight.new({x: 7, y: 1}, "\u265E", name) : Knight.new({x: 0, y: 1}, "\u2658", name)
    @knight2 = name == "white" ? Knight.new({x: 7, y: 6}, "\u265E", name) : Knight.new({x: 0, y: 6}, "\u2658", name)
    @rook1 = name == "white" ? Rook.new({x: 7, y: 0}, "\u265C", name) : Rook.new({x: 0, y: 0}, "\u2656", name)
    @rook2 = name == "white" ? Rook.new({x: 7, y: 7}, "\u265C", name) : Rook.new({x: 0, y: 7}, "\u2656", name)
    @bishop1 = name == "white" ? Bishop.new({x: 7, y: 2}, "\u265D", name) : Bishop.new({x: 0, y: 2}, "\u2657", name)
    @bishop2 = name == "white" ? Bishop.new({x: 7, y: 5}, "\u265D", name) : Bishop.new({x: 0, y: 5}, "\u2657", name)
    @pawn1 = name == "white" ? Pawn.new({x: 6, y: 0}, "\u265F", name) : Pawn.new({x: 1, y: 0}, "\u2659", name)
    @pawn2 = name == "white" ? Pawn.new({x: 6, y: 1}, "\u265F", name) : Pawn.new({x: 1, y: 1}, "\u2659", name)
    @pawn3 = name == "white" ? Pawn.new({x: 6, y: 2}, "\u265F", name) : Pawn.new({x: 1, y: 2}, "\u2659", name)
    @pawn4 = name == "white" ? Pawn.new({x: 6, y: 3}, "\u265F", name) : Pawn.new({x: 1, y: 3}, "\u2659", name)
    @pawn5 = name == "white" ? Pawn.new({x: 6, y: 4}, "\u265F", name) : Pawn.new({x: 1, y: 4}, "\u2659", name)
    @pawn6 = name == "white" ? Pawn.new({x: 6, y: 5}, "\u265F", name) : Pawn.new({x: 1, y: 5}, "\u2659", name)
    @pawn7 = name == "white" ? Pawn.new({x: 6, y: 6}, "\u265F", name) : Pawn.new({x: 1, y: 6}, "\u2659", name)
    @pawn8 = name == "white" ? Pawn.new({x: 6, y: 7}, "\u265F", name) : Pawn.new({x: 1, y: 7}, "\u2659", name)
    @pieces = [@king, @queen, @knight1, @knight2, @rook1, @rook2, @bishop1, @bishop2, 
      @pawn1, @pawn2, @pawn3, @pawn4, @pawn5, @pawn6, @pawn7, @pawn8]
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
    if piece.class == Pawn
      if piece.promotable?
      promote_result = promote_pawn(piece) 
      result[:promotion?] = true
      result[:promoted_coor] = promote_result[:coor]
      result[:new_piece] = promote_result[:new_piece]
      end
    end
    result
  end

  def valid_piece? coor
    formatted_coor = coor_converter(coor)
    @pieces.any? {|piece| piece.coor == formatted_coor}
  end

  def get_player_piece coor
    formatted_coor = coor_converter(coor)
    @pieces.select {|piece| piece.coor == formatted_coor}[0]
  end

  def moveable_piece? coor, board, enemy_pieces, check_mate_check = false
    return false unless valid_piece?(coor)
    piece = get_player_piece coor
    possible_moves = piece.possible_moves(board)
    possible_safe_moves = safe_move(possible_moves, piece, enemy_pieces, board)
    return true if possible_safe_moves.size > 0
    puts "That piece has no legal moves for now." if @king.check == false && check_mate_check == false && self.class == HumanPlayer
    puts "Your king is checked! Protect Your King!!" if @king.check == true && self.class == HumanPlayer
    false
  end

  def remove_dead_piece 
    @pieces = @pieces.reject {|piece| piece.alive == false}
  end

  def king_checked? enemy_pieces, board, alter, king_coor = @king.coor
    result = enemy_pieces.any? {|enemy_piece| enemy_piece.possible_moves(board).include? king_coor}
    @king.check = result if alter == true 
    result
  end

  def safe_move possible_moves, piece, enemy_pieces, board
    possible_moves.reject do |possible_move|
      predict_result = predict_after_move(board, piece.coor, possible_move, piece, enemy_pieces)
      predict_enemy_pieces = predict_result[:predict_enemy_pieces]
      predict_board = predict_result[:predict_board]
      if piece.class == King
        king_checked? predict_enemy_pieces, predict_board, false, possible_move
      else
        king_checked? predict_enemy_pieces, predict_board, false
      end
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
      duplicate_enemy_pieces.delete_if {|duplicate_enemy_piece| duplicate_enemy_piece.coor == attacked_piece.coor}
    end
    duplicate_board[after_x][after_y][:piece] = piece
    {predict_board: duplicate_board, predict_enemy_pieces: duplicate_enemy_pieces}
  end
end