require_relative "pieces.rb"
require_relative "board.rb"
require_relative "display.rb"
require_relative "player.rb"
# require "byebug"

class Game
  def initialize
    @board = Board.new
    @player = Player.new(@board)
  end

  def run
    until @board.checkmate?(:w) || @board.checkmate?(:b)
      pos = @player.move
    end
    puts "Checkmate!"
  end
end


if __FILE__ == $PROGRAM_NAME
  puts "running Game.new"
  Game.new.run
end
