class Board
  attr_reader :grid, :display
  attr_accessor :current_player

  def initialize(fill = true)
    @grid = Array.new(8) { Array.new(8) {Null.new} }
    @display = Display.new(self)
    @current_player = :w
    populate if fill
  end

  def [](pos)
    x, y = pos
    grid[y][x]
  end

  def []=(pos, val)
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

  def move!(board, start, end_pos)
    board[end_pos] = board[start]
    board[start] = Null.new
    #piece
    board[end_pos].pos = end_pos
    board
  end

  def switch_turn
    if @current_player == :w
      @current_player = :b
    else
      @current_player = :w
    end
  end

  def move(start, end_pos, color)

    if valid_moves(color).include?([start, end_pos]) === false
      raise "can't move that there"
    elsif self[start].is_empty?
      raise "no piece bro"
    elsif start === end_pos
      raise "you\'re not going anywhere..."
    elsif @current_player != @grid[start[1]][start[0]].color
      raise "not yer turn"
    end

    #board
    self[end_pos] = self[start]
    self[start] = Null.new
    #piece
    self[end_pos].pos = end_pos
    self
    switch_turn
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
      piece.find_moves(board).each do |move|
        other_teams_moves << move
      end
    end
    other_teams_moves
  end

  def valid_moves(color)
    if color === :b
      color_opp = :w
    else
      color_opp = :b
    end
    valid_moves = []
    dup_board = dup_board(self)
    other_teams_moves(dup_board, color_opp).each do |start, end_pos|
      dup_board = dup_board.move!(dup_board, start, end_pos)
      if move_into_check?(dup_board, color)
        dup_board = dup_board(self)
        next
      else
        valid_moves << [start, end_pos]
        dup_board = dup_board(self)
      end
    end
    valid_moves
  end

  def checkmate?(color)
    if color === :b
      color_opp = :w
    else
      color_opp = :b
    end
    return true if valid_moves(color_opp).empty?
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
