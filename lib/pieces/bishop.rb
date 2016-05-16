class Bishop < Piece
  include Slideable

  def to_s
    if @color == :w
      " \u{2657} "
    else
      " \u{265D} "
    end
  end

  def dirs_can_move
    DIAGONALS
  end
end
