class Interface

  def choose_move(player, deck)
    begin
    choose_move_prompt(player, deck)
    input = gets.chomp.downcase
    if input == "draw"
      player.draw_check(deck)
    else
      raise BadInputError unless valid?(input)
      choose_card(player, deck)
    end
    rescue BadInputError
      puts "That is not a valid choice."
      retry
    rescue HasPlayError => e
      puts e.message
      sleep 2
      retry
    end
  end

  def choose_card(player, deck)
    begin
    system("clear")
    system('cls') # windows
    deck.top_card
    puts "Which card would you like to play? Enter a number or J, Q, K, A: "
    player.show_hand
    card_val = gets.chomp.upcase
    if card_val == "DRAW"
      player.draw_check(deck)
    else
      raise BadInputError.new if card_val == ""
      card = player.valid_card?(card_val, deck)
      raise NoCardError.new "That is not a card you can play." if card == nil
    end
  rescue NoCardError => e
      puts
      puts e.message
      sleep 1.7
      retry
    rescue BadInputError
        retry
    rescue NoPlayError => e
      puts e.message
      sleep 2
      choose_move(player, deck)
    rescue HasPlayError => e
      puts e.message
      sleep 2
      retry
    end
    player.play_card(card, deck)
  end

  def valid?(input)
    input == "play" || input == "draw" || input == "p" || input == "d"
  end



  def choose_suit
    puts "Choose a suit! "
    gets.chomp.to_sym
  end

  def choose_move_prompt(player, deck)
    system("clear")
    system('cls')  # windows
    puts "#{player.name}'s turn:"
    puts "Match the suit or value, play an eight, or draw a new card!"
    deck.top_card
    puts "Play or draw a card?"
    player.show_hand
  end

end

class NoCardError < ArgumentError
end

class BadInputError < ArgumentError
end

class HasPlayError < ArgumentError
end
