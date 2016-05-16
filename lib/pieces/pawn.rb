require "colorize"
require 'byebug'
class Pawn < Piece

  PAWN_W = [
    [0, 1],
    [1, 1],
    [-1, 1],
    [0, 2]
  ]

  PAWN_B = [
    [0, -1],
    [1, -1],
    [-1, -1],
    [0, -2]
  ]

  def dirs_can_move
    if self.color == :w
      PAWN_W
    else
      PAWN_B
    end
  end

  def to_s
    if @color == :w
      " \u{2659} "
    else
      " \u{265F} "
    end
  end

  def find_moves(board = self.board)
    moves = []
    self.dirs_can_move.each.with_index do |dir, idx|
      x_dir, y_dir = dir
      x, y = self.pos

      x = x + x_dir
      y = y + y_dir

      new_pos = [x, y]
      next unless board.in_bounds?(new_pos)
      piece_in_new_pos = board[new_pos]


      case idx

      when 0 # fwd move
        next unless piece_in_new_pos.is_empty?
      when 1 #capture
        next if piece_in_new_pos.color == self.color || piece_in_new_pos.is_empty?
      when 2 #capture
        next if piece_in_new_pos.color == self.color || piece_in_new_pos.is_empty?
      when 3 # fwd 2 from starting pos
        next unless piece_in_new_pos.is_empty?
        if self.color === :w
          next unless self.board[[new_pos[0], new_pos[1] - 1]].is_empty?
        else
          next unless self.board[[new_pos[0], new_pos[1] + 1]].is_empty?
        end

        if @color == :w
          next unless self.pos[1] == 1
        else
          next unless self.pos[1] == 6
        end
      end

      moves << [self.pos, new_pos]
    end
   moves
  end

end
