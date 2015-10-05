module Mastermind

  class Game_Engine 
    attr_reader :status
    def initialize(col=nil)
      starter = Starter.new
      @computer_code = Code_generator.new.computer_choice(col)
      @player = Player.new
      @msg = Message.new
      @status = :started
    end

    def exact_match(computer_code, player_input)
      exact = 0
      i = 0 
      comp_copy = computer_code.dup             
        while i < comp_copy.length
          if comp_copy[i] == player_input[i]
            exact += 1
            comp_copy[i] = nil
          end
            i += 1
        end
      [comp_copy, exact]
    end                                   

    def partial_match(comp_copy, player_input)
      partial = 0
      i = 0                                                                 
      sec_copy = comp_copy.dup
      while i < sec_copy.length
        if !sec_copy[i].nil? && sec_copy.include?(player_input[i])
          partial += 1
          sec_copy[i] = nil
          end     
      i += 1
      end
      partial                                                       
    end   

    def replay
      puts "
      Would you like to play again? (y)es, (n)o"
      player_input = Input.new.user_input
      if player_input == "y"
        Starter.new.difficulty
      elsif player_input =="n"
        puts "
        Thanks for playing! :)"
        exit
      else
        puts "#{@msg.invalid_entry_msg}"
        replay
      end
    end

    def game(col)
      @counter = 0
      @start_time = Time.now
      loop do
        player_input = @player.player_entry(col)
        exact = exact_match(@computer_code, player_input) 
        partial = partial_match(exact[0], player_input)
        @counter += 1
        analysis(player_input, exact[1], partial)
        break if exact[1] == exact[0].length
      end
      winner(col)
    end

    def analysis(player_input, exact = nil, partial = nil)
      puts "
      You entered #{player_input}" 
      try_again(exact, partial)     
    end

    def winner(col)
      final_time = (Time.now - @start_time).to_i
      puts "
      Nicely Done!. You won in #{final_time} seconds
      The computer chose #{@computer_code}"
      @status = :winner
      replay
    end

    def try_again(exact, partial)
      final_time = (Time.now - @start_time).to_i
      puts "
      You have #{exact} exact matches and #{partial} partial matches"
      if @counter >= 12
        puts "
        Game Over!                                      
        :( You Loose ):
      The computer chose #{@computer_code}            
      You  played the game for #{final_time} seconds"
      replay
      end

    end

    
  end #end class



end #end module
