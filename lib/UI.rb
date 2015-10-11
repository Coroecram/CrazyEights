class Interface

  def choose_card(player)
    puts "Which card would you like to play? Enter a number: "
    show_hand(player)
    card_id = gets.chomp.to_i
    card = player.hand[card_id]
  end

  def choose_move(player, deck)
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
  player.hand.each { |card| print " | #{card} |  " }
  puts
end

end
