class Rook < Piece
  include Slideable

  # attr_reader :dirs_can_move

  def to_s
    if @color == :w
      "\u{2656} "
    else
      "\u{265C} "
    end
  end

  def dirs_can_move
    ORTHOGONALS
  end

end
