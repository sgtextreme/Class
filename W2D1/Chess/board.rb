require_relative "pieces"
require "colorize"
class Board
  attr_reader :grid
  def initialize
    @grid = Array.new(8){Array.new(8){NullPiece.new("P")}}

  end

  # def self.generate_board
  #   @grid.each_index do |i|
  #     @grid[i].each_index do |j|
  #
  # end
  def in_bounds(pos)
    self[pos].nil?
  end

  def [](pos)
    x,y = pos
    @grid[x][y]
  end

  def render

  end

end
