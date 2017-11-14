require_relative "pieces"
require "colorize"
class Board
  attr_reader :grid, :board
  def initialize
    @grid = Array.new(8){ Array.new(8) }
    generate_board_black
    generate_board_white
    generate_empty
  end
  #
  def generate_board_black
    @grid[0][0] = Rook.new("\u265C", :R, board)
    @grid[0][7] = Rook.new("\u265C", :R, board)
    @grid[0][1] = Knight.new("\u265E", :Kn, board)
    @grid[0][6] = Knight.new("\u265E", :Kn, board)
    @grid[0][2] = Bishop.new("\u265D", :B, board)
    @grid[0][5] = Bishop.new("\u265D", :B, board)
    @grid[0][3] = King.new("\u265A", :K, board)
    @grid[0][4] = Queen.new("\u265B", :Q, board)
    @grid[1].each_index do |i|
      @grid[1][i] = Pawn.new("\u265F", :P, board)
    end
  end

  def generate_empty
    (2..5).each do |i|
      @grid[i].each_index do |j|
        @grid[i][j] = NullPiece.new("E",:NP, board)
      end
    end
  end
  #
  def generate_board_white
    @grid[7][7] = Rook.new("\u2656", :R, board)
    @grid[7][0] = Rook.new("\u2656", :R, board)
    @grid[7][1] = Knight.new("\u2658", :Kn, board)
    @grid[7][6] = Knight.new("\u2658", :Kn, board)
    @grid[7][2] = Bishop.new("\u2657", :B, board)
    @grid[7][5] = Bishop.new("\u2657", :B, board)
    @grid[7][3] = King.new("\u2654", :K, board)
    @grid[7][4] = Queen.new("\u2655", :Q, board)
    @grid[6].each_index do |i|
      @grid[6][i] = Pawn.new("\u2659", :P, board)
    end
  end

  def move_piece(start_pos, end_pos)
    raise "No starting piece" if self[start_pos].nil?
    raise "not a valid end_pos" if end_pos.any? { |el| !el.between?(0,7) }
    if valid_move?(start_pos, end_pos)
      sp = self[start_pos]
      ep = self[end_pos]
      self[start_pos] = ep
      self[end_pos] = sp
    end
  end


  def in_bounds(pos)
    pos.all? { |el| el.between?(0,7) }
  end

  def [](pos)
    x,y = pos
    @grid[x][y]
  end

  def []=(pos, value)
    x,y = pos
    @grid[x][y] = value
  end

  def valid_move?(start_pos, end_pos)
    self[start_pos].grow_unblocked_move_in_dir(start_pos).include?(end_pos)
  end





end
