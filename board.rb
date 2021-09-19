class Board
  attr_reader :board
  def initialize
    @board = (1..8).to_a.reverse.map do |row|
      [{coor: "A#{row}", piece: nil}, {coor: "B#{row}", piece: nil}, 
        {coor: "C#{row}", piece: nil}, {coor: "D#{row}", piece: nil},
        {coor: "E#{row}", piece: nil}, {coor: "F#{row}", piece: nil},
        {coor: "G#{row}", piece: nil}, {coor: "H#{row}", piece: nil},]
    end
  end
end