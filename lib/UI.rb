class Interface

  def choose_card(player)
    begin
    puts "Which card would you like to play? Enter a number or J, Q, K, A: "
    show_hand(player)
    card = gets.chomp
    card = player.valid_card?(card)
    raise "That is not a card you have" if card == nil
    rescue
      retry
    end
    play(card)
  end

  def choose_move(player, deck)
    begin
    puts "Match the suit or value, play an eight, or draw a new card!"
    puts deck.last_discarded
    puts "Play or draw a card?"
    input = gets.chomp
    raise "Not a valid option" unless valid?(input)
    rescue
      retry
    end
    return input if input == "draw"
    choose_card(player)
  end

  def valid?(input)
    input == "play" || input == "draw" || input == "p" || input == "d"
  end

  def choose_suit
    puts "Choose a suit! "
    gets.chomp.to_sym
  end

  def show_hand(player)
    player.hand.each_with_index do |card, idx|
      puts "\n\n" if idx % 5 == 0
      print " | #{card} |  "
    end
    puts
  end

end
