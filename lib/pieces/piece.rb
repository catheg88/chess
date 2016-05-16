require "colorize"

class Piece
  attr_reader :color, :board
  attr_accessor :pos

  def initialize(color)
    @color = color
  end

  def is_empty?
    false
  end

  def set_pos(board, pos)
    @board = board
    @pos = pos
  end

  def opposite_color
    if @color == :w
      :b
    else
      :w
    end
  end

end
