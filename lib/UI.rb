class Interface

  def choose_card(player, deck)
    begin
    system("clear")
    system('cls') # windows
    puts deck.last_discarded
    puts "Which card would you like to play? Enter a number or J, Q, K, A: "
    show_hand(player)
    card_val = gets.chomp.upcase
    raise BadInputError.new if card_val == ""
    card = player.valid_card?(card_val, deck)
    raise NoCardError.new if card == nil
    rescue NoCardError
      puts
      puts "That is not a card you have."; sleep 1.7; puts
      retry
    rescue BadInputError
        retry
    end
    play(card)
  end

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
    rescue PlayError => e
      puts e.message
      sleep 2
      retry
    end
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
    puts "Match the suit or value, play an eight, or draw a new card!"
    puts deck.last_discarded
    puts "Play or draw a card?"
    show_hand(player)
  end

  def show_hand(player)
    player.hand.each_with_index do |card, idx|
      puts "\n\n" if idx % 5 == 0
      print " | #{card} |  "
    end
    puts
  end

end

class NoCardError < ArgumentError
end

class BadInputError < ArgumentError
end

class HasPlayError < ArgumentError
end
