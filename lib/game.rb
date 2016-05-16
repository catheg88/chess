require_relative "pieces"
require_relative "board"
require_relative "display"
require_relative "player"

class Game
  def initialize
    @board = Board.new
    @player = Player.new(@board)
  end

  def switch_turn
    if @board.current_player == :w
      @board.current_player = :b
    else
      @board.current_player = :w
    end
  end

  def run
    until @board.checkmate?(:w) || @board.checkmate?(:b)
      pos = @player.move
    end
    puts "Checkmate!"
  end
end

if __FILE__ == $PROGRAM_NAME
  Game.new.run
end
