require_relative 'player/black_player.rb'
require_relative 'player/white_player.rb'
require_relative 'board.rb'
require_relative 'util/chess_util.rb'

class Game
  include ChessUtil
  def initialize 
    @white_player = WhitePlayer.new "white"
    @black_player = BlackPlayer.new "black"
    @board = Board.new @white_player.pieces, @black_player.pieces
    @current_player = @white_player
    @enemy_player = @black_player
  end

  def play
    until game_over?
      player_turn
    end
    @board.print_board
    puts "Checkmate! Player #{@enemy_player.name} wins!!"
  end

  def player_turn
    @board.print_board
    puts "Player #{@current_player.name}'s turn"
    puts "Your king is checked!!" if @current_player.king_checked? @enemy_player.pieces, @board.board, true
    move_result = @current_player.player_move @board.board, @enemy_player.pieces
    @board.update_board(move_result[:before], move_result[:after], move_result[:piece])
    @board.change_piece(move_result[:promoted_coor], move_result[:new_piece]) if move_result[:promotion?] == true
    change_turn
  end

  def change_turn
    @current_player = @current_player == @white_player ? @black_player : @white_player
    @enemy_player = @enemy_player == @white_player ? @black_player : @white_player
  end

  def game_over?
    @current_player.pieces.none? do |piece|
      @current_player.moveable_piece?(coor_display_formatter(piece.coor), @board.board, @enemy_player.pieces, true)
    end
  end
end