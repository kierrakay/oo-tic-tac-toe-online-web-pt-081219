
require 'pry'


class TicTacToe

  def initialize(board = nil)
    @board = board || Array.new(9, " ")
    @TicTacToe = play
  end
  
  # The "pipes" || = or. This is saying that if the board returns nil, return an empty array.  So, either display the current board, or a new one.

# WIN_COMBINATIONS within the body of TicTacToe
  
  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6]
  ]
  
  #display_board: not the instance variable @board
  
    def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end
  
    
  # input_index
  
  def input_to_index(user_input)
    user_input.to_i - 1
  end
  
  # move: Note that we deleted the board arguement, and added @ to board.  For instance, #move was move(board, position, char), but now board is intialized, so it is a characteristic of TicTacToe, no need to have it as an argument.  So, #move became simply move(position, char).
  
  def move(position, char)
    @board[position] = char
  end
    
    # For #move to work, we need to position_taken and valid_move
    
  def position_taken?(index_i)
    ((@board[index_i] == "X") || (@board[index_i] == "O"))
  end

  def valid_move?(index)
    index.between?(0,8) && !position_taken?(index)
  end
  
  
  #turn_count
  def turn_count
    number_of_turns = 0
    @board.each do |space|
    if space == "X" || space == "O"
        number_of_turns += 1
    end
  end
  return number_of_turns
end


#So the % is called the modulo operator. It basically checks for the remainder after dividing 2 numbers.https://stackoverflow.com/a/3517240

  def current_player
    if turn_count % 2 == 0
    "X"
    else
    "O"
  end
end

# % (modulo) divides the turn by 2  to return the remainder to find if the number is even or odd. if the number is even it'll return "X" which is player "X" if the number is odd it goes to the second player who is player "O" for them to select a turn.

#turn 
def turn
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    char = current_player
    if valid_move?(index)
      move(index, char)
      display_board
    else
      turn
    end
end
#Sanitizing User Input: The strip and chomp Methods
#One thing to know about the #gets method is that it captures a new line character at the end of whatever input it is storing. We don't want extra whitespace or new lines to be appended to the user input we are trying to store. So, we can chain a call to the #strip method to remove any new lines or leading and trailing whitespace.

#The #chomp method works similarly, and you are likely to see #gets.chomp used in some examples online. The #chomp method removes any new lines at the end of a string while the #strip method removes whitespace (leading and trailing) and new lines.


def won? # shows winning combination
    WIN_COMBINATIONS.detect do |win_combo|
    if (@board[win_combo[0]]) == "X" && (@board[win_combo[1]]) == "X" && (@board[win_combo[2]]) == "X"
      return win_combo
    elsif (@board[win_combo[0]]) == "O" && (@board[win_combo[1]]) == "O" && (@board[win_combo[2]]) == "O"
      return win_combo
    end
      false
  end
end

#[0,1,2] is the first win combo array so the code will see if "x" or "o" has this combo to determine if it has won if not it'll return false and go through the next winning combos. we use our WIN_COMBINATIONS CONSTANT for this. Constant means these are the only way to win...thats why they are constant. not meant to change. detect...it looks for the first combo to reign true . 

def full?
  @board.all?{|occupied| occupied != " "}
end

# != Checks if the value of two operands are equal or not, if values are not equal then condition becomes true. (a != b) is true.


#draw
def draw?
  !(won?) && (full?)
end

#over?
def over?
  won? || full? || draw?
end

def winner # tells if "X" or "O" won. very similar to  def won? method. 
  WIN_COMBINATIONS.detect do |win_combo|
    if (@board[win_combo[0]]) == "X" && (@board[win_combo[1]]) == "X" && (@board[win_combo[2]]) == "X"
      return "X"
    elsif (@board[win_combo[0]]) == "O" && (@board[win_combo[1]]) == "O" && (@board[win_combo[2]]) == "O"
      return "O"
    else
      nil
    end
  end
end

#play
def play 
  while over? == false
    turn
  end
  if won?
    puts "Congratulations #{winner}!"
  elsif draw?
    puts "Cat's Game!"
  end
end


end


