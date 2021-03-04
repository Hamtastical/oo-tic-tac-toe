require "pry"

class TicTacToe #assign a cclass to encappsulate all methods

    # attr_accessor :board

    WIN_COMBINATIONS = [
        [0,1,2], #top row
        [3,4,5], #mid row
        [6,7,8], #bottom row
        [0,3,6], #left top to bottom
        [1,4,7], #mid top to bottom
        [2,5,8], #right top to bottom
        [0,4,8], #left to right diagnol
        [2,4,6] #right to left diagnol
    ]

    def initialize(board = nil) #initialize board (default to = nil)
        @board = board || Array.new(9," ") #@board == board OR Array.new (9," ")
    end

    def display_board

        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} " #puts boards as string interpolating, then calls board with the index
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    def input_to_index(user_input) #takes method that takes an input

        user_input.to_i - 1 #take user input, make to an integer aand then -1 due to index starting from 0

    end

    def move(index, token = "X" || "O") #method that takes an argument of the index, then of the token
        @board[index] = token #calls instance variable of the board, and which index that is selected, then = token where it would go 
    end

    def position_taken?(index) #this method is taken and runs through the input_to_index method
 
        if @board[index] == " " #returns false if position is not occupied
            false
        else @board[index] == "X" || "O" #if position IS occupied, returns true
            true
        end
    end

    def valid_move?(index) #method takes index to see if it is a valid move
        # binding.pry
        if index.between?(0, 8) && !position_taken?(index)  #if the board find the position is NOT occupied between index 0-8, then true
            true
        else
            false
        end
    end

    def turn_count
        @board.count { |token| token == "X" || token == "O"} #count the board, with a token that is there. does not equal empty spaces
        # binding.pry
    end

    def current_player

        if turn_count % 2 == 0 #if turn is divisible by 2(or even) and no remainder, gets X
            token = "X"

        else
            token = "O" #if not divisible (or odd) gets O
        end
    end

    def turn
        user_input = gets.chomp #asks recieve input
        player = input_to_index(user_input) #put input to index value into a variable that recieves the input
        
        if valid_move?(player)  #if valid, make move and display board
            move(player, current_player)
            display_board

        else !valid_move?(player)#if invalid, ask again until move is valid
            user_input = gets.chomp #asks recieve input
            player = input_to_index(user_input) #put input to index value into a variable that recieves the input
        end
    end

    def won?

         WIN_COMBINATIONS.find do |win| #use.find to go through this to find the winning combination (.find is another way to iterate)
                # binding.pry
                @board[win[0]] == @board[win[1]] &&  @board[win[1]] == @board[win[2]] && position_taken?(win[0]) 
                #goes through each index of each element and see if it matches, then gets help method position_taken? to see if the position is taken
   
        end
    end

    def full?   #if full

        @board.all? {|spot| spot != " "} #iterate through the board, it goes through the spots and if it does not == " " its full
      
    end

    def draw?
      full? && !won?
    end

     def over?
        draw? || won?
    end

    def winner
        @board[won?[0]]  if won?
    end
        


    def play
        until over?
            turn
        end

        won? ? congratulate : draw 
    end

    def congratulate

        puts "Congratulations #{winner}!"

    end

    def draw
        puts "Cat's Game!"
end

    
end