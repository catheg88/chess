class Knight < Piece
  include Stepable

  def dirs_can_move
    KNIGHT
  end


  def to_s
    if @color == :w
      " \u{2658} "
    else
      " \u{265E} "
    end
  end
end
