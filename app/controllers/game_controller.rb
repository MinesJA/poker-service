class GameController < ApplicationController

  include GameService
  
  # header = {
  #   round_count: 100,
  #   holes => {1 => ["KD", "3D"], 2 => [], 3 => [], 4 => []},
  #   community => {
  #     flop => ["4D", "5C", "JS"],
  #     turn => [],
  #     river => []
  #   }
  # }
  # 
  # resp = {
  #   rounds: [Round.class]
  # }
  def create
    # Run x number of games with y number of players
    # Collect all rounds

    byebug
    
    deck = Deck.new()
  
    holes = params[:holes].map{|player, card_shorts| 
      cards = card_shorts.map{|s| deck.pull(Card.from_str(short: s))}
      [player, cards]}.to_h

    community =params[:community].map{|type, card_shorts| 
      cards = card_shorts.map{|s| deck.pull(Card.from_str(short: s))}
      [type, cards]}.to_h
                  

    player_count = params[:player_count]

    rounds = play_rounds(
      round_count: params[:round_count], 
      deck: params[:rounds], 
      holes: holes, 
      community: community,
    )

    
    
    




 

  end
end
