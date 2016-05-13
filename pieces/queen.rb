class Queen < Piece
  include Slideable


  def to_s
    if @color == :w
      "\u{2655} "
    else
      "\u{265B} "
    end
  end

  def dirs_can_move
    DIAGONALS + ORTHOGONALS
  end
end
