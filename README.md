# Crazy eights

For fun colors with colorize uncomment line 1 and line 79 in game.

## Rules

* You have **HOWEVER THE HECK LONG YOU WANT** for this fake assessment. Do not worry if you do not
  complete all the assessment; finish as much as you can.
* Descriptions of each method to implement are written into the `lib/`
  files. For each `lib/` file, there is a corresponding `spec/` file.
* Run the specs as you solve the assessment. Solve the assessment in
  this order:

```
bundle exec rspec spec/card_spec.rb
bundle exec rspec spec/deck_spec.rb
bundle exec rspec spec/player_spec.rb
```

game.rb is included.

## Game Rules

* You read the rules on wikipedia right? I'm just gonna copy and paste...

Eight cards are dealt to each player. The remaining cards of the deck are placed face down at the center of the table. The top card is then turned face up to start the game.

Players discard by matching rank or suit with the top card of the discard pile, starting with the player left of the dealer. If a player is unable to match the rank or suit of the top card of the discard pile and does not have an eight, he or she draws cards from the stockpile until getting a playable card. When a player plays an eight, he or she must declare the suit that the next player is to play; that player must then follow the named suit or play another eight.

As an example: Once the six of clubs is played the next player:

can play any of the other sixes
can play any of the clubs
can play any eight (then must declare a different suit)
can draw from the stockpile until willing and able to play one of the above
Typically the game doesn't take very long, but its time frame can vary greatly.
