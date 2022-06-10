# : End the game
require 'pry-byebug'
require_relative 'board'

class Game
  def initialize
    @board = Board.new
  end

  def get_pos
    prefix, pos = nil, nil

    until (pos && prefix) && (valid_prefix?(prefix) && valid_pos?(pos))
      puts "Please enter prefix and position (eg. 'f3,4' or 'r3,4'):"
      print "> "

      prefix, pos = parse_pos(gets.chomp)
    end

    [prefix, pos]
  end


  def play_turn
    # REVEIW: Refactor properly
    puts board.render
    prefix, position = get_pos
    next_move(prefix, position)
  end

  def run
    play_turn until game_over?
  end

  private

  attr_reader :board

  def game_over?
    @board.win? # FIXME: blank false for debugging
  end

  def next_move(pref, pos)
    tile = @board[pos]

    case pref
    when 'f'
      tile.flag
    when 'r'
      tile.reveal
    end
  end

  def valid_pos?(pos) # pos=>{ r=>[3,4] }

    if pos.is_a?(Array) &&
      pos.length == 2 &&
      pos.all? { |num| num.between?(0, board.grid_size - 1)}

      true
    else
      get_pos
    end
  end

  def valid_prefix?(str)
    prefix = ['f', 'r']
    prefix.include?(str)
  end

  def parse_pos(str_pos)
    pref = str_pos[0]
    pos = str_pos[1..-1].split(',').map(&:to_i)

    [pref, pos]
  end
end

if __FILE__ == $PROGRAM_NAME
  # TODO: refactor it to start game properly
  game = Game.new
  game.run
end
