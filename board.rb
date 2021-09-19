require 'colorize'

class Board
  attr_reader :board
  def initialize white_player_pieces, black_player_pieces
    @board = (1..8).to_a.reverse.map do |row|
      [{coor: "A#{row}", piece: nil}, {coor: "B#{row}", piece: nil}, 
        {coor: "C#{row}", piece: nil}, {coor: "D#{row}", piece: nil},
        {coor: "E#{row}", piece: nil}, {coor: "F#{row}", piece: nil},
        {coor: "G#{row}", piece: nil}, {coor: "H#{row}", piece: nil},]
    end

    white_player_pieces.each do |piece|
      x = piece.coor[:x]
      y = piece.coor[:y]
      @board[x][y][:piece] = piece
    end

    black_player_pieces.each do |piece|
      x = piece.coor[:x]
      y = piece.coor[:y]
      @board[x][y][:piece] = piece
    end
  end

  def print_board
    puts "    A   B   C   D   E   F   G   H  "
    puts "  ---------------------------------"
    row_mark = ['8', '7', '6', '5', '4', '3', '2', '1']
    @board.each.with_index do |row, row_idx|
      print "#{row_mark[row_idx]} |"
      row.each do |square|
        print_square square[:piece]
      end
      print " #{row_mark[row_idx]}"
      puts ""
      puts "  ---------------------------------"
    end
    puts "    A   B   C   D   E   F   G   H  "
  end

  def print_square piece
    if piece == nil
      print "   |"
    else
      print " #{piece.symbol} |"
    end
  end
end