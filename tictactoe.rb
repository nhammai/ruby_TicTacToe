class Player
    attr_accessor :name, :symbol
  
    def initialize(name, symbol)
      @name = name
      @symbol = symbol
    end
  end
  
  class Board
    attr_reader :board
  
    def initialize
      @board = Array.new(9, " ")
    end
  
    def display_board
      puts "#{@board[0]} | #{@board[1]} | #{@board[2]}"
      puts "-----------"
      puts "#{@board[3]} | #{@board[4]} | #{@board[5]}"
      puts "-----------"
      puts "#{@board[6]} | #{@board[7]} | #{@board[8]}"
    end
  
    def place_mark(index, player)
      @board[index] = player.symbol
    end
  
    def check_win(player)
      win_combinations = [ 
        [0,1,2], # top_row 
        [3,4,5], # middle_row 
        [6,7,8], # bottom_row 
        [0,3,6], # left_column 
        [1,4,7], # center_column 
        [2,5,8], # right_column 
        [0,4,8], # left_diagonal 
        [6,4,2]  # right_diagonal 
      ]
  
      win_combinations.each do |win_combination|
        win_index_1, win_index_2, win_index_3 = win_combination
        position_1 = @board[win_index_1] # value of board at win_index_1
        position_2 = @board[win_index_2] # value of board at win_index_2
        position_3 = @board[win_index_3] # value of board at win_index_3  
  
        if position_1 == position_2 && position_2 == position_3 && position_taken?(win_index_1)
          return true
        end
      end
      false
    end
  
    def check_draw
      @board.all? { |position| position != " " }
    end
  
    def position_taken?(index)
      @board[index] != " "
    end
  end
  
  class Game
    def initialize(player1, player2)
      @player1 = player1
      @player2 = player2
      @board = Board.new
      @current_player = @player1
    end
  
    def switch_player
      @current_player = @current_player == @player1 ? @player2 : @player1
    end
  
    def play
      until @board.check_win(@current_player) || @board.check_draw
        @board.display_board
        puts "#{@current_player.name}, enter a number between 1 and 9:"
        index = gets.chomp.to_i - 1
        @board.place_mark(index, @current_player)
        switch_player
      end
  
      @board.display_board
  
      if @board.check_win(@current_player)
        puts "#{@current_player.name} wins!"
      else
        puts "It's a draw!"
      end
    end
  end
  
  player1 = Player.new("Player 1", "X")
  player2 = Player.new("Player 2", "O")
  game = Game.new(player1, player2)
  game.play
  