WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]

class Board

  def initialize
    @board = {}
   (1..9).each {|position| @board[position] = Square.new(' ')}
  end

  def new_board
    @board = {}
    (1..9).each {|position| @board[position] = Square.new(' ')}
    draw_board
  end

  def draw_board
    system 'clear'
    puts "TIC, TAC, T0E"
    puts "     |     |     "
    puts "  #{@board[1]}  |  #{@board[2]}  |  #{@board[3]}  "
    puts "     |     |     "
    puts "------------------"
    puts "     |     |     "
    puts "  #{@board[4]}  |  #{@board[5]}  |  #{@board[6]}  "
    puts "     |     |     "
    puts "------------------"
    puts "     |     |     "
    puts "  #{@board[7]}  |  #{@board[8]}  |  #{@board[9]}  "
    puts "     |     |     "
  end

  def all_squares_taken?
    empty_squares.size == 0
  end

  def empty_squares
    @board.select {|k, square| square.empty?}.values
  end

  def empty_positions
    @board.select {|k, square| square.empty?}.keys
  end

  def mark_square(position, marker)
    @board[position].mark(marker)
  end

  def winning_lines(marker)
    WINNING_LINES.each do |line|
      return true if @board[line[0]].value == marker && @board[line[1]].value == marker && @board[line[2]].value == marker
    end
    false
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
  attr_accessor :value

  def initialize(value)
  @value = value 
  end

  def mark(marker)
    @value = marker
  end

  def empty?
    @value == ' '
  end

  def to_s
    @value
  end
end

class Game
  attr_accessor :coin_flip
  def initialize
    @board = Board.new
    @human = Player.new('Eric', 'X')
    @computer = Player.new('Mac', '0')
    @current_player = @human
  end

  def current_player_chooses_square
    if @current_player == @human
      begin
        puts "Please choose a square: #{@board.empty_positions}."
        position = gets.chomp.to_i
      end until @board.empty_positions.include?(position)
    else
      position = @board.empty_positions.sample
    end
      @board.mark_square(position, @current_player.marker)
  end

  def alternate_player
    if @current_player == @human
      @current_player = @computer
    else
      @current_player = @human
    end
  end

  def choose_current_player(coin_choice)
    if [1, 2].sample == 1
      puts "It's heads"
    else
      @current_player = @computer
    end
  end

  def welcome_message
    puts "Welcome to Tic, Tac, Toe."
    puts "I'm flipping a coin to see who goes first, do you want heads or tails?"
  end

  def choose_first_player 
    begin
      puts "Hit (1) for heads and (2) for tails"
      coin_choice = gets.chomp.to_i
    end until (1..2).include?(coin_choice)
     system 'clear'
    if coin_choice == 1
      puts "You chose heads."
      coin_choice = 'heads'
      non_choice = 'tails'
    else
      puts "You chose tails."
      coin_choice = 'tails'
      non_choice = 'heads'
    end
    sleep 1
    coin_flip = ['heads', 'tails'].sample
    if coin_choice == coin_flip
      puts "The coin shows #{coin_choice}."
      sleep 1
      puts "You go first!"
      @current_player = @human
    else
      puts "The coin shows #{non_choice}."
      sleep 1
      puts "Computer goes first."
      @current_player = @computer
    end
    sleep 2
  end

  def current_player_wins?
    @board.winning_lines(@current_player.marker)
  end

  def play_again?
    puts "Would you like to play again? (Y/N)"
    gets.chomp.upcase == 'Y'
  end 

  def winning_message
    puts "#{@current_player.name} wins!"
  end

  def play
    welcome_message
    loop do
      choose_first_player
      @board.new_board
      loop do
      current_player_chooses_square
      @board.draw_board
        if current_player_wins?
          winning_message
          break
        elsif @board.all_squares_taken?
          puts "It's a tie."
          break
        else
          alternate_player
        end
      end
      break unless play_again?
    end
  end
end

Game.new.play