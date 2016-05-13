
class Board
  attr_reader :grid, :display

  def initialize(fill = true)
    @grid = Array.new(8) { Array.new(8) {Null.new} }
    @display = Display.new(self)
    populate if fill
  end

  def [](pos)
    # debugger
    x, y = pos
    grid[y][x]
  end

  def []=(pos, val)
    # debugger
    x, y = pos
    grid[y][x] = val
  end

  def populate
    @grid[0] = [Rook.new(:w), Knight.new(:w), Bishop.new(:w),
      Queen.new(:w), King.new(:w), Bishop.new(:w), Knight.new(:w), Rook.new(:w)]
    @grid[1] = Array.new(8) {Pawn.new(:w)}
    @grid[6] = Array.new(8) {Pawn.new(:b)}
    @grid[7] = [Rook.new(:b), Knight.new(:b), Bishop.new(:b),
      Queen.new(:b), King.new(:b), Bishop.new(:b), Knight.new(:b), Rook.new(:b)]
    @grid.each.with_index do |row, y|
      row.each.with_index do |piece, x|
        piece.set_pos(self, [x, y])
      end
    end
  end

  def move!(board, start, end_pos, color)
    board[end_pos] = board[start]
    board[start] = Null.new
    #piece
    board[end_pos].pos = end_pos
    board
  end

  def move(start, end_pos, color)

    # loop do
    #   if valid_moves(:w).include?([start, end_pos])
    #     break
    #   else
    #     puts "nah you can't move that there "
    #   end
    # end



    # begin
    #   raise "No piece bro" if self[start].is_empty?
    #   retry

    #board
    self[end_pos] = self[start]
    self[start] = Null.new
    #piece
    self[end_pos].pos = end_pos
    self
  end

  def in_bounds?(pos)
    return false if pos[0] < 0 || pos[1] < 0
    pos[0] < 8 && pos[1] < 8
  end

  def in_check?(board, color)
    king_pos = find_king(board, color)
    other_teams_moves(board, color).any? do |start, end_pos|
      king_pos == end_pos
    end
  end

  def find_king(board, color)
    # debugger
    board.grid.each.with_index do |row, y|
      row.each.with_index do |col, x|
        piece = self[[x, y]]
        return [x, y] if piece.class == King && piece.color == color
      end
    end
  end

  def other_teams_moves(board, color)
    other_team_pieces = []
    board.grid.each.with_index do |row, y|
      row.each.with_index do |col, x|
        piece = self[[x, y]]
        other_team_pieces << piece if piece.opposite_color == color
      end
    end

    other_teams_moves = []
    other_team_pieces.each do |piece|
      piece.find_moves.each do |move|
        other_teams_moves << move
      end
    end

    other_teams_moves
  end

  def valid_moves(color)
    # debugger
    valid_moves = []
    dup_board = dup_board(self)
    other_teams_moves(dup_board, color).each do |start, end_pos|
      dup_board = dup_board.move!(dup_board, start,end_pos, :w)
      if move_into_check?(dup_board, :w)
        next
      else
        valid_moves << [start, end_pos]
      end
    end

    puts "#{color}'s valid_moves #{valid_moves}"
    valid_moves
  end


  def checkmate?(color)
    return true if valid_moves(color).empty?
    false
  end

  def dup_board(board)
    new_board = Board.new(false)
    @grid.each.with_index do |row, y|
      row.each.with_index do |col, x|
        piece = self[[x, y]]
        new_board[[x, y]] = piece.dup
      end
    end
    new_board
  end



  def move_into_check?(dup_board, color)
    dup_board.in_check?(dup_board, color)
  end

end
