require_relative 'player'

class ComputerPlayer < Player
  def choose_piece board, enemy_pieces 
    valid_piece = @pieces.select do |piece|
      coor = coor_display_formatter(piece.coor)
      valid_coor?(coor) && valid_piece?(coor) && moveable_piece?(coor, board, enemy_pieces)
    end
    chosen_valid_piece = valid_piece.sample
    chosen_coor = coor_display_formatter(chosen_valid_piece.coor)
    get_player_piece chosen_coor
  end

  def move_piece available_move_options
    p available_move_options
    coor = available_move_options.sample
    formatted_coor = coor_converter(coor)
  end

  def promote_pawn piece
    coor = piece.coor
    choice = (1..4).to_a.sample
    @pieces.delete piece
    new_piece = case choice 
    when 1 
      Queen.new(coor, @name == 'white' ? "\u265B" : "\u2655",@name)
    when 2
      Bishop.new(coor, @name == "white" ? "\u265D": "\u2657", @name)
    when 3
      Knight.new(coor, @name == "white" ? "\u265E": "\u2658", @name)
    when 4
      Rook.new(coor, @name == "white" ? "\u265C" : "\u2656", @name)
    end
    @pieces << new_piece
    {coor: coor, new_piece: new_piece}
  end
end