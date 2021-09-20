require_relative 'piece'

class Rook < Piece
  def possible_moves board
    possible_moves = []
    up = up_possible_moves board
    down = down_possible_moves board
    left = left_possible_moves board
    right = right_possible_moves board

    possible_moves.concat(up).concat(down).concat(left).concat(right)
    possible_moves.map{|possible_move| {x: possible_move[0], y: possible_move[1]}}
  end

  
  def up_possible_moves board
    up = []
    (1..7).to_a.each do |move|
      x = @coor[:x] - move
      y = @coor[:y]
      if x < 0 || x > 7
        break
      elsif board[x][y][:piece] == nil
        up << [x,y]
      elsif board[x][y][:piece].owner == @owner
        break
      elsif board[x][y][:piece].owner != @owner
        up << [x,y]
        break
      end 
    end
    up
  end

  def down_possible_moves board
    down = []
    (1..7).to_a.each do |move|
      x = @coor[:x] + move
      y = @coor[:y]
      if x < 0 || x > 7
        break
      elsif board[x][y][:piece] == nil
        down << [x,y]
      elsif board[x][y][:piece].owner == @owner
        break
      elsif board[x][y][:piece].owner != @owner
        down << [x,y]
        break  
      end
    end
    down
  end

  def right_possible_moves board
    right = []
    (1..7).to_a.each do |move|
      x = @coor[:x]
      y = @coor[:y] - move
      if y < 0 || y > 7
        break
      elsif board[x][y][:piece] == nil
        right << [x,y]
      elsif board[x][y][:piece].owner == @owner
        break
      elsif board[x][y][:piece].owner != @owner
        right << [x,y]
        break
      end 
    end
    right
  end

  def left_possible_moves board
    left = []
    (1..7).to_a.each do |move|
      x = @coor[:x]
      y = @coor[:y] + move
      if y < 0 || y > 7
        break
      elsif board[x][y][:piece] == nil
        left << [x,y]
      elsif board[x][y][:piece].owner == @owner
        break
      elsif board[x][y][:piece].owner != @owner
        left << [x,y]
        break
      end
    end
    left
  end
end
