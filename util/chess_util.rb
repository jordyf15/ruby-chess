module ChessUtil 
  def coor_converter coor
    splitted_coor = coor.split('')
    x = case splitted_coor[1]
    when '8'
      0
    when '7'
      1
    when '6'
      2
    when '5'
      3
    when '4'
      4
    when '3'
      5
    when '2'
      6
    else '1'
      7
    end
    y = case splitted_coor[0]
    when 'A'
      0
    when 'B'
      1
    when 'C'
      2
    when 'D'
      3
    when 'E'
      4
    when 'F'
      5
    when 'G'
      6
    else 'H'
      7
    end
    {x: x, y: y}
  end

  def valid_coor? coor
    splitted_coor = coor.split('')
    return false if coor.size != 2
    x_ascii = splitted_coor[0].ord
    y_ascii = splitted_coor[1].ord
    return false if  x_ascii < 65 || x_ascii > 72
    return false if y_ascii < 49 || y_ascii > 56
    true
  end
end