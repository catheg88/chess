require_relative "pieces.rb"
require_relative "board.rb"
require_relative "display.rb"
require_relative "player.rb"
# require "byebug"

class Game
  def initialize
    puts "making new game"
    @board = Board.new
    @player = Player.new(@board)
    @x = 0
  end

  def run
    puts "Game.new.run"
    until @board.checkmate?(:w) || @board.checkmate?(:b)
      @x += 1
      puts "in the run until, #{@x}"
      pos = @player.move

    end
    puts "checkmate"
  end
end


if __FILE__ == $PROGRAM_NAME
  puts "running Game.new"
  Game.new.run
end
