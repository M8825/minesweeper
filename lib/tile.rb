class Tile
  ROW = [-1, -1, -1, 0, 0, 0, 1, 1, 1]
  COL = [-1, 0, 1, -1, 0, 1, -1, 0, 1]

  attr_reader :pos

  def initialize(board, pos)
    @grid = board
    @pos = pos
    @flagged = false
    @revealed = false
    @bombed = false
  end

  def flagged?
    @flagged
  end

  def revealed?
    @revealed
  end

  def bombed?
    @bombed
  end

    def inspect
      { pos: pos,
        bombed: bombed?,
        flagged: flagged?,
        explored: revealed? }.inspect
    end

  def neighbors()
    row, col = pos
  
    row.each_index.map do |i|
      n_row = ROW[i]
      n_col = COL[i]
      @grid[row + n_row][col + n_col]
    end
  end

  def neighbor_bomb_count
    neighbors.count { |tile| tile.bombed?}
  end

  def [](pos)
    row, col = pos
    grid[row][col]
  end

  def plant_bomb
    @bombed = true
  end

end
