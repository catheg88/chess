require_relative "pieces.rb"
require_relative "board.rb"
require_relative "display.rb"
# require_relative "display_test.rb"
require_relative "player.rb"
require "byebug"

# b = Board.new
#
#
# b.grid.each do |row|
#   puts row.join(" ")
# # end
# byebug

class Game
  def initialize
    @board = Board.new
    @player = Player.new(@board)
  end

  def run
    # @board.move([3, 7], [5, 1])
    puts "Mark all the spaces on the board!"
    puts "WASD or arrow keys to move the cursor, enter or space to confirm."
    until @board.checkmate?(:w) || @board.checkmate?(:b)

      pos = @player.move


    end
    puts "checkmate"
  end
end

if __FILE__ == $PROGRAM_NAME
  Game.new.run
end
