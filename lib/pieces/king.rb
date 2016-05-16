class King < Piece
  include Stepable

  def dirs_can_move
    KING
  end


  def to_s
    if @color == :w
      " \u{2654} "
    else
      " \u{265A} "
    end
  end
end
