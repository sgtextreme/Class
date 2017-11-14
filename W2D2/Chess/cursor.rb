require "io/console"
require_relative "board"
require_relative "display"

KEYMAP = {
  " " => :space,
  "h" => :left,
  "j" => :down,
  "k" => :up,
  "l" => :right,
  "w" => :up,
  "a" => :left,
  "s" => :down,
  "d" => :right,
  "\t" => :tab,
  "\r" => :return,
  "\n" => :newline,
  "\e" => :escape,
  "\e[A" => :up,
  "\e[B" => :down,
  "\e[C" => :right,
  "\e[D" => :left,
  "\177" => :backspace,
  "\004" => :delete,
  "\u0003" => :ctrl_c,
}

MOVES = {
  left: [0, -1],
  right: [0, 1],
  up: [-1, 0],
  down: [1, 0]
}

class Cursor

  attr_reader :cursor_pos, :board, :selected, :previous_pos

  def initialize(cursor_pos, board)
    @cursor_pos = cursor_pos
    @board = board
    @selected = false
    @previous_pos = nil
  end

  def get_input
    key = KEYMAP[read_char]
    handle_key(key)
  end

  def update_pos(diff)
    x, y = diff
    x1, y1 = @cursor_pos
    @cursor_pos = (x1 + x > 7 || x1 + x  < 0 ) || (y1 + y > 7 || y1+ y < 0) ?  [x,y] :  [x1+x, y+y1]
  end

  def toggle_selected
    @selected = @selected == false ? true : false
  end

  def handle_key(key)

    if key == :space
      toggle_selected
      @cursor_pos
      @previous_pos = cursor_pos
    elsif key == :return
      if selected == true
        @board.move_piece(@previous_pos, @cursor_pos)
        @previous_pos = nil
        toggle_selected
      end
      @cursor_pos
    elsif key == :ctrl_c
      Process.exit(0)
    elsif MOVES.keys.include?(key)
      update_pos(MOVES[key])
    end

  end
  private

  def read_char
    STDIN.echo = false # stops the console from printing return values

    STDIN.raw! # in raw mode data is given as is to the program--the system
                 # doesn't preprocess special characters such as control-c

    input = STDIN.getc.chr # STDIN.getc reads a one-character string as a
                             # numeric keycode. chr returns a string of the
                             # character represented by the keycode.
                             # (e.g. 65.chr => "A")

    if input == "\e" then
      input << STDIN.read_nonblock(3) rescue nil # read_nonblock(maxlen) reads
                                                   # at most maxlen bytes from a
                                                   # data stream; it's nonblocking,
                                                   # meaning the method executes
                                                   # asynchronously; it raises an
                                                   # error if no data is available,
                                                   # hence the need for rescue

      input << STDIN.read_nonblock(2) rescue nil
    end

    STDIN.echo = true # the console prints return values again
    STDIN.cooked! # the opposite of raw mode :)

    return input
  end

end
