require_relative 'piece'

class Bishop < Piece
  def possible_moves board
    possible_moves = []
    diagonal_up_left = diagonal_up_left_possible_moves board
    diagonal_up_right = diagonal_up_right_possible_moves board
    diagonal_down_left = diagonal_down_left_possible_moves board
    diagonal_down_right = diagonal_down_right_possible_moves board

    possible_moves.concat(diagonal_up_left).concat(diagonal_up_right)
      .concat(diagonal_down_left).concat(diagonal_down_right)
      .map{|possible_move| {x: possible_move[0], y: possible_move[1]}}
  end

  def diagonal_up_left_possible_moves board
    diagonal_up_left = []
    (1..7).to_a.each do |move|
      x = @coor[:x ] - move
      y = @coor[:y] - move
      if x < 0 || x > 7 || y < 0 || y > 7
        break
      elsif board[x][y][:piece] == nil
        diagonal_up_left << [x,y]
      elsif board[x][y][:piece].owner == @owner
        break
      elsif board[x][y][:piece].owner != owner
        diagonal_up_left << [x, y]
        break
      end
    end
    diagonal_up_left
  end

  def diagonal_up_right_possible_moves board
    diagonal_up_right = []
    (1..7).to_a.each do |move|
      x = @coor[:x ] - move
      y = @coor[:y] + move
      if x < 0 || x > 7 || y < 0 || y > 7
        break
      elsif board[x][y][:piece] == nil
        diagonal_up_right << [x,y]
      elsif board[x][y][:piece].owner == @owner
        break
      elsif board[x][y][:piece].owner != owner
        diagonal_up_right << [x, y]
        break
      end
    end
    diagonal_up_right
  end

  def diagonal_down_left_possible_moves board
    diagonal_down_left = []
    (1..7).to_a.each do |move|
      x = @coor[:x ] + move
      y = @coor[:y] - move
      if x < 0 || x > 7 || y < 0 || y > 7
        break
      elsif board[x][y][:piece] == nil
        diagonal_down_left << [x,y]
      elsif board[x][y][:piece].owner == @owner
        break
      elsif board[x][y][:piece].owner != owner
        diagonal_down_left << [x, y]
        break
      end
    end
    diagonal_down_left
  end

  def diagonal_down_right_possible_moves board
    diagonal_down_right = []
    (1..7).to_a.each do |move|
      x = @coor[:x ] + move
      y = @coor[:y] + move
      if x < 0 || x > 7 || y < 0 || y > 7
        break
      elsif board[x][y][:piece] == nil
        diagonal_down_right << [x,y]
      elsif board[x][y][:piece].owner == @owner
        break
      elsif board[x][y][:piece].owner != owner
        diagonal_down_right << [x, y]
        break
      end
    end
    diagonal_down_right
  end
end