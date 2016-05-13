require 'colorize'
require_relative "cursorable"

class Display
  attr_reader :board

  include Cursorable

  def initialize(board)
    @board = board
    @cursor_pos = [0, 0]
    @cursor_pos_selected = false
  end

  def build_grid
    @board.grid.map.with_index do |row, rownum|
      build_row(row, rownum)
    end
  end

  def build_row(row, rownum)
    row.map.with_index do |square, colnum|
      color_options = colors_for(colnum, rownum)
      square.to_s.colorize(color_options)
    end
  end

  def colors_for(i, j)
    if [i, j] == @cursor_pos
      { background: :red }
    elsif [i, j] == @cursor_pos_selected
      { background: :red }
    elsif (i + j).odd?
      { background: :magenta }
    else
      { background: :green }
    end
  end

  def render
    system("clear")
    puts "Arrow keys, WASD, or vim to move, space or enter to confirm."
    puts "In check White: #{@board.in_check?(@board, :w)}"
    puts "In check Black: #{@board.in_check?(@board, :b)}"
    puts "In checkmate White: #{@board.checkmate?(:b)}"
    puts "In checkmate Black: #{@board.checkmate?(:w)}"
    build_grid.each { |row| puts row.join("") }
  end
end
