require 'pry-byebug' #TODO: remove once done
require_relative 'tile'

class Board
    def init_grid
      Array.new(9) do |row|
        Array.new(9) { |col| Tile.new(self, [row, col]) }
      end
    end

  attr_reader :grid
  
  def initialize(board = self.init_grid)
    @grid = board
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def plant_bombs
      num_of_bombs = 0
      g_s = 10 # TODO: Make it abstract
  
      until num_of_bombs == g_s
          rand_row = rand(0..8)
          rand_col = rand(0..8)
          rand_pos = [rand_row, rand_col]
  
          tile = self[rand_pos]
          next if tile.bombed?
  
          tile.plant_bomb
          num_of_bombs += 1
      end
  end

  def render
    puts ' ' + (0..8).to_a.join(' ')
    @grid.each_with_index.map do |row, i|
      row.map(&:render).join(' ')
    end.join("\n")
  end

  def play_turn
    # TODO: logic for game over
    render
  end

  private

  def grid_size
    @grid.length
  end
end
