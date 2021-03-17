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
    
    
      render json: run_rounds(
        run_count: game_params[:run_count], 
        player_count: game_params[:player_count],  
        holes: game_params[:holes], 
        community: game_params[:community]
      ), status: 200
    
    
    # TODO: Need custom serialization for Round class
    # render json: round, status: 200
  end

  private

  def game_params
    params.require(:game).permit(:run_count, :player_count, :holes => {}, community: [flop: [], turn: [], river: []])
  end
end
