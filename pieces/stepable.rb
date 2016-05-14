module Stepable

  KING = [
    [1, 0],
    [-1, 0],
    [0, -1],
    [0, 1],
    [1, 1],
    [-1, 1],
    [1, -1],
    [-1, -1]
  ]

  KNIGHT = [
   [-2, -1],
   [-2,  1],
   [-1, -2],
   [-1,  2],
   [ 1, -2],
   [ 1,  2],
   [ 2, -1],
   [ 2,  1]
 ]

  def find_moves
    # puts "find_moves stepable"
    moves = []
    self.dirs_can_move.each do |dir|
      x_dir, y_dir = dir
      x, y = self.pos

      x = x + x_dir
      y = y + y_dir
      new_pos = [x, y]

      next unless self.board.in_bounds?(new_pos)

      piece_in_new_pos = self.board[new_pos]
      unless piece_in_new_pos.is_empty?
        next if piece_in_new_pos.color == self.color
      end

      moves << [self.pos, new_pos]
    end
   # debugger
   moves
  end

end
