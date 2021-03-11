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

    
  
    holes = game_params[:holes].to_h.map{|player, card_shorts|
      cards = card_shorts.map{|s| deck.pull(Card.from_str(short: s))}
      [player, cards]}.to_h


    byebug

    community = game_params[:community].map{|type, card_shorts| 
      cards = card_shorts.map{|s| deck.pull(Card.from_str(short: s))}
      [type, cards]}.to_h

    rounds = play_rounds(
      round_count: game_params[:round_count], 
      deck: game_params[:rounds], 
      holes: holes, 
      community: community,
    )
    byebug
    render json: rounds, status: 200
  end

  private

  def game_params
    params.require(:game).permit(:round_count, :holes => {}, community: [flop: [], turn: [], river: []])
  end
end
