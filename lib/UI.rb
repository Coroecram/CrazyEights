class Interface

  def choose_card(player)
    puts "Which card would you like to play? Enter a number: "
    show_hand(player)
    card_id = gets.chomp.to_i
    card = player.hand[card_id]
  end

  def choose_suit
    puts "Choose a suit! "
    gets.chomp.to_sym
  end

  def show_hand(player)
    player.hand.each_with_index { |card, idx| print "#{idx}=>#{card}  " }
    puts
  end

end
