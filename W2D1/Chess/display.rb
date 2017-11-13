require_relative "cursor"
require_relative "board"
require "colorize"
require "byebug"
class Display

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0],@board)
  end

  def render
    @board.grid.each_with_index do |el,i|
      rows = ""
      el.each_with_index do |piece,j|
        if @cursor.cursor_pos == [i,j]
          rows << @board.grid[i][j].name.colorize(:blue) + " "
        else
          rows <<  @board.grid[i][j].name + " "
        end
      end
      puts rows
    end
  end

    def move_cursor
      until @cursor.selected == true
        pos = @cursor.get_move
        @cursor.update_pos(pos)
        render
      end
    end








end
if __FILE__ == $PROGRAM_NAME
new_disp = Display.new(Board.new)
new_disp.move_cursor
end
