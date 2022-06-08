require_relative 'tile'
class Board

  def init_grid
    Array.new(9) do |row|
      Array.new(9) { |col| Tile.new(self, [row, col]) }
    end
  end

  def initialize(board = self.init_grid)
    @grid = board
  end

end
