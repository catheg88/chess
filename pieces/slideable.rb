module Slideable

  ORTHOGONALS = [
    [1, 0],
    [-1, 0],
    [0, -1],
    [0, 1]
  ]

  DIAGONALS = [
    [1, 1],
    [-1, 1],
    [1, -1],
    [-1, -1]
  ]

  def find_moves
    # puts "find_moves slideable"
    moves = []
    self.dirs_can_move.each do |dir|
      x_dir, y_dir = dir
      x, y = self.pos
      loop do
        x = x + x_dir
        y = y + y_dir
        new_pos = [x, y]

        break unless self.board.in_bounds?(new_pos)

        piece_in_new_pos = self.board[new_pos]
        unless piece_in_new_pos.is_empty?
          break if piece_in_new_pos.color == self.color
          moves << [self.pos, new_pos]
          break
        end

        moves << [self.pos, new_pos]
      end
    end
    # debugger
    moves
  end

end
