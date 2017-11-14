require_relative "cursor"
require_relative "board"
require "colorize"
require "byebug"
class Display

  def initialize(board = Board.new)
    @board = board
    @cursor = Cursor.new([0,0],@board)
  end

  def render
    @board.grid.each_with_index do |el,i|
      rows = ""
      el.each_with_index do |piece,j|

        if  @cursor.previous_pos == [i,j]
          x,y = @cursor.previous_pos
          rows << @board[[x,y]].name.colorize(:background => :red) + " "
        elsif @cursor.selected == true && @cursor.cursor_pos != @cursor.previous_pos && @cursor.cursor_pos == [i,j]
          rows << @board[[i,j]].name.colorize(:background => :blue)
        elsif @cursor.cursor_pos == [i,j]
          rows << @board[[i,j]].name.colorize(:background => :blue) + " "
        else
          rows <<  @board[[i,j]].name + " "
        end
      end
      puts rows
    end
  end

  def move_cursor
    while true
      render
      @cursor.get_input
      system ("clear")
    end
  end



end
if __FILE__ == $PROGRAM_NAME
new_disp = Display.new(Board.new)
new_disp.move_cursor
end
