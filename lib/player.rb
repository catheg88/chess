require_relative "display"

class Player
  attr_reader :display

  def initialize(board)
    @board = board
    @display = board.display
  end

  def move
    result = nil
    until result
      @display.render
      result = @display.get_input
    end
    result
  end
end
