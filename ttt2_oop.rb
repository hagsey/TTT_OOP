WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]

class Board
  def initialize
    @board = {}
    @board.each {|position| @board[position] = Square.new(' ')}
  end

end


class Player
  def initialize(name, marker)

end

class Square

end

class Game
  def initialize
    @board = Board.new
    @human = Player.new('Eric', 'X')
    @computer = Player.new('Mac', '0')
    @current_player = @human
end