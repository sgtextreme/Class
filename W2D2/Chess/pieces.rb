require "singleton"


module SteppingPiece
  # def moves()
  # end

  def move_dirs(sym, start)
    if sym == :Kn
      l_move(start)
    elsif sym == :K
      king_move(start)
    else
      pawn_move(start)
    end
  end

  def pawn_move(start)
    x,y = start
    moves = [[x+1,y+1],[x+1,y-1],[x-1,y+1],[x-1,y-1],[x+1,y],[x,y+1],[x-1,y],[x,y-1]]
    moves.select { |el| el[0].between?(0,7) && el[1].between?(0,7) }
  end

  def king_move(start)
    x,y = start
    moves = [[x+1,y+1],[x+1,y-1],[x-1,y+1],[x-1,y-1],[x+1,y],[x,y+1],[x-1,y],[x,y-1]]
    moves.select { |el| el[0].between?(0,7) && el[1].between?(0,7) }
  end

  def l_move(start)
    valid_moves(start)
  end

  def valid?(move, pos)
    x, y = move
    x1, y1 = pos
    pos_add = x1 - x
    move_add = y1 - y
    (pos_add.abs + move_add.abs) == 3 && (x1 - x).abs < 3 && (y1 - y).abs < 3
  end

  def valid_moves(pos)
    result = []
    (0..7).each do |x|
      (0..7).each do |y|
        result << [x,y] if valid?([x,y], pos)
      end
    end
    result
  end
end

module SlidingPiece
  def moves()
  end



  def move_dirs(sym, start)
    if sym == :Q
      side_dirs(start) + diagoanal_dirs(start)
    elsif sym == :B
      diagonal_dirs(start)
    else
      side_dirs(start)
    end

  end

  def side_dirs(start)
    moves = []
    x,y = start
    board = Array.new(8) {Array.new(8)}
    board.each_with_index do |el,i|
      moves << [x,y+i] if (y+i).between?(0,7)
      moves << [x,y-i] if (y-i).between?(0,7)
      el.each_index do |j|
        moves << [x+j,y] if (x+j).between?(0,7)
        moves << [x-j,y] if (x-j).between?(0,7)
      end

    end
    moves
  end



  def diagonal_dirs(start)
    moves = []
    x,y = start
    board = Array.new(8) {Array.new(8)}
    board.each_index do |i|
      if (x+i).between?(0,7) #&& nothit

        if (y+i).between?(0,7) #&& [x+i,y+i] == E

          moves << [x+i,y+i]
        else
          nothit = false
        end
        if (y-i).between?(0,7)
          moves << [x+i,y-i]
        end
      end
      if (x-i).between?(0,7)
        if (y+i).between?(0,7)
          moves << [x-i,y+i]
        end
        if (y-i).between?(0,7)
          moves << [x-i,y-i]
        end
      end
    end
    moves.uniq
  end



end
class Piece
  attr_reader :name, :symbol, :board
  def initialize(name, symbol,board)
    @name = name
    @symbol = symbol
    @board = board
  end

  def move_into_check(to_pos)

  end


end

class NullPiece < Piece
  # include Singleton

end

class Pawn < Piece
  include SteppingPiece
  def grow_unblocked_move_in_dir(start)
    move_dirs(symbol, start)
  end
end

class Rook < Piece
  include SlidingPiece
  def possible_move(start,board)
    move_dirs(symbol,start,board)
  end
  def grow_unblocked_move_in_dir(start)
    # moves = []
    # x,y = start
    # board = Array.new(8) {Array.new(8)}
    # board.each_with_index do |el,i|
    #   moves << [x,y+i] if (y+i).between?(0,7)
    #   moves << [x,y-i] if (y-i).between?(0,7)
    #   el.each_index do |j|
    #     moves << [x+j,y] if (x+j).between?(0,7)
    #     moves << [x-j,y] if (x-j).between?(0,7)
    #   end
    #
    # end
    # moves

  end

end

class Queen < Piece
  include SlidingPiece
  def possible_move(start,board)
    move_dirs(symbol,start,board)
  end

  def grow_unblocked_move_in_dir(start)

  end

end
class Bishop < Piece
  include SlidingPiece
  def possible_move(start,board)
    move_dirs(symbol,start,board)
  end

  def grow_unblocked_move_in_dir(start)
    debugger
    moves = []
    x,y = start
    xplusyplus = true
    xplusymins = true
    xminsymins = true
    xminsyplus = true
    board.grid.each_index do |i|
      xplusyplus = false if board[[x+i,y+i]].class != NullPiece
      xplusymins = false if board[[x+i,y-i]].class != NullPiece
      xminsymins = false if board[[x-i,y-i]].class != NullPiece
      xminsyplus = false if board[[x-i,y+i]].class != NullPiece
      if (x+i).between?(0,7)
        if (y+i).between?(0,7) && xplusyplus
          moves << [x+i,y+i]
        end
        if (y-i).between?(0,7) && xplusymins
          moves << [x+i,y-i]
        end
      end
      if (x-i).between?(0,7)
        if (y+i).between?(0,7) && xminsyplus
          moves << [x-i,y+i]
        end
        if (y-i).between?(0,7) && xminsymins
          moves << [x-i,y-i]
        end
      end
    end
    moves.uniq
  end

end

class Knight < Piece
  include SteppingPiece
end

class King < Piece
  include SteppingPiece
end
