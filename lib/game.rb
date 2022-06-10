require 'pry-byebug'
require_relative 'board'

class Game
  def initialize
    @board = Board.new
  end

  def play
    board.plant_bombs
    puts board.render
    foo = board[[5,3]]
    foo.reveal
    puts board.render
  end

  private

  attr_reader :board
end

if __FILE__ == $PROGRAM_NAME
  # TODO: refactor it to start game properly
  game = Game.new
  game.play
end
