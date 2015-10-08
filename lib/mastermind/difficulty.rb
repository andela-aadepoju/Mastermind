require "colorize"
require_relative 'input'

module Difficulty

  def difficulty
    puts "#{@msg.difficulty_select}"

     input = user_input
     case 
    when input == "b"
      puts "#{@msg.beginer_msg}"
      col = 0
      begin_game(col)
    when input == "m"
      puts "#{@msg.intermidiate_msg}"
      col = 2
      begin_game(col)
    when input == "a"
      puts "#{@msg.advance_msg}"
      col = 4
      begin_game(col) 
    else  
        puts "#{@msg.invalid_entry_msg}"
        difficulty
    end
  end
end