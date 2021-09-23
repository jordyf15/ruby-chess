require_relative 'player'

class HumanPlayer < Player
  def choose_piece board, enemy_pieces 
    print "Please choose the piece you want to move or 'save' if you want to save the game: "
    coor = gets.chomp
    return "save game" if coor == "save"
    coor = coor.upcase
    until valid_coor?(coor) && valid_piece?(coor) && moveable_piece?(coor, board, enemy_pieces)
      print "Please input a valid coordination of one of your piece: "
      coor = gets.chomp
    end
    get_player_piece coor
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

  def promote_pawn piece
    coor = piece.coor
    choice = 0
    puts "To promote your pawn please input 1-4: "
    puts "1. Queen"
    puts "2. Bishop"
    puts "3. Knight"
    puts "4. Rook"
    until choice >= 1 && choice <= 4
      puts "Please input between 1 and 4 to promote this pawn"
      choice = gets.chomp.to_i
    end
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