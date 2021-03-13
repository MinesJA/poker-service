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

    
    # Todo: This is technically deserialization, for which we could have a
    # custom strategy
    holes = game_params[:holes].to_h.map do |player, card_shorts|
                # {1: ["kd", ...], ...}
                cards = card_shorts.map do |s| 
                  deck.pull(Card.from_str(s))
                end
                [player, cards] 
    end.to_h
    # {1: [<Card>]}

    # Todo: deserialization strategy.....
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
    # Todo: ensure rounds has custom serialization
    render json: rounds, status: 200
  end

  private

  def game_params
    params.require(:game).permit(:round_count, :holes => {}, community: [flop: [], turn: [], river: []])
  end
end
