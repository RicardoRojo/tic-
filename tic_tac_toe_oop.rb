# Tic Tac Toe
# By Ricardo Rojo
# 02/02/2015
# ============
class Board
  WINNING_LINES = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]

  def initialize
    @data = {}
    (1..9).each {|index| @data[index] = Square.new}
  end
  def draw
    system 'clear'
    puts
    puts "     |     |"
    puts "  #{@data[1]}  |  #{@data[2]}  |  #{@data[3]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@data[4]}  |  #{@data[5]}  |  #{@data[6]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@data[7]}  |  #{@data[8]}  |  #{@data[9]}"
    puts "     |     |"
    puts
  end

  def mark_position(position,marker)
    @data[position].change_value(marker)
  end

  def all_squares_marked?
    self.empty_positions.size == 0
  end

  def three_in_a_row?(marker)
    WINNING_LINES.each do |line|
      return true if @data[line[0]].value == marker && @data[line[1]].value == marker && @data[line[2]].value == marker
    end
    false
  end

  def empty_positions
    @data.select {|_,square| square.empty?}.keys
  end

end

class Player
  attr_reader :name, :marker
  def initialize(name, marker)
    @name = name
    @marker = marker
  end
end

class Square
  attr_reader :value
  def initialize
    @value = " "
  end
  def to_s
    @value
  end
  def empty?
    @value == " "
  end
  def change_value(marker)
    @value = marker
  end
end
class Game
  attr_accessor :current_player
  def initialize
    @board = Board.new
    @human = Player.new("bob", "X")
    @computer = Player.new("WOPR", "O")
    @current_player = @human
  end
  def play
    @board.draw
    loop do
      pick_position
      @board.draw
      if current_player_win?
        puts "#{current_player.name} Wins!!"
        break
      elsif @board.all_squares_marked?
        puts "It´s a tie"
        break
      else
        alternate_player
      end
    end
  end

  private

  def current_player_win?
    @board.three_in_a_row?(current_player.marker)
  end
  def pick_position
    if current_player == @human
      begin
        puts "Choose a position #{@board.empty_positions}"
        position = gets.chomp.to_i
      end until @board.empty_positions.include?(position)
    else
      position = @board.empty_positions.sample
    end
    @board.mark_position(position, current_player.marker)

  end
  def alternate_player
    if @current_player == @human
      self.current_player = @computer
    else
      self.current_player = @human
    end
  end
end

Game.new.play