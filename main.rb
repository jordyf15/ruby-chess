require_relative "board"
require "./player/white_player"
require "./player/black_player"

white_player = WhitePlayer.new "white"
black_player = BlackPlayer.new "black"
board = Board.new white_player.pieces, black_player.pieces
board.print_board