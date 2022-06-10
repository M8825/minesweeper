require 'pry-byebug'
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
      revealed: revealed? }.inspect
  end

  def reveal
    return self if @flagged
    return self if @revealed

    @revealed = true
    if !bombed? && (neighbor_bomb_count == 0) # If any of the adjacent neighbors have no bombs
      neighbors.each { |tile| tile.reveal unless tile.flagged? }    # they too are revealed
    end

    self
  end

  def reveal_bombs
    @revealed = true if bombed?
  end

  def render
    if flagged?
      'F'
    elsif bombed? && revealed? # This can be true if player just revealed bombed tile
      'B'
    elsif revealed?
      neighbor_bomb_count == 0 ? '_' : neighbor_bomb_count.to_s
    else
      '*'
    end
  end

  def neighbors
    row, col = pos
  
    ROW.each_index.map do |i|
      n_row, n_col = ROW[i] + row, COL[i] + col

      next if (n_row < 0 || n_row > 8) || (n_col < 0 || n_col > 8)
      neighbor = [n_row, n_col]

      @grid[neighbor]
    end.compact
  end

  def neighbor_bomb_count
    neighbors.count { |tile| tile.bombed?}
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def plant_bomb
    @bombed = true
  end

  def flag
    flagged? ? @flagged = false : @flagged = true unless revealed?
  end
end
