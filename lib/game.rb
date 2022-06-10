# NOTE: End the game
require 'pry-byebug'
require_relative 'board'

class Game
  def initialize
    @board = Board.new
  end

  def play_turn
    # REVIEW:Refactor properly
    puts board.render
    prefix, position = get_pos
    next_move(prefix, position)
  end

  def run
    play_turn until game_over?

    board.end_game
    puts board.render
  end

  private

  attr_reader :board

  def get_pos
    prefix, pos = nil, nil

    until (pos && prefix) && (valid_prefix?(prefix) && valid_pos?(pos))
      puts "Please enter prefix and position (eg. 'f3,4' or 'r3,4'):"
      print "> "

      begin
        prefix, pos = parse_pos(gets.chomp)
      rescue
        puts 'Invalid input, please try again'
        puts ''
        prefix, pos = nil, nil
      end
    end

    [prefix, pos]
  end

  def game_over?
    @board.win? || @board.lost?
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

      return true
    end

    false
  end

  def valid_prefix?(str)
    prefix = ['f', 'r']
    prefix.include?(str)
  end

  def parse_pos(str_pos)
    pref = str_pos[0]
    pos = str_pos[1..-1].split(',').map { |str_num| Integer(str_num)}

    [pref, pos]
  end
end

if __FILE__ == $PROGRAM_NAME
  game = Game.new
  game.run
end
