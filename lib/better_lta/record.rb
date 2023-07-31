module BetterLTA
  class Record
    attr_reader :wins, :losses, :ties, :runs_scored, :runs_allowed

    def initialize(wins: 0, losses: 0, ties: 0, runs_scored: 0, runs_allowed: 0, points: 0)
      @wins = wins
      @losses = losses
      @ties = ties
      @runs_scored = runs_scored
      @runs_allowed = runs_allowed
    end

    def record_result(score:, opponent_score:)
      if score > opponent_score
        @wins += 1
      elsif score < opponent_score
        @losses += 1
      else
        @ties += 1
      end

      @runs_scored += score
      @runs_allowed += opponent_score
    end

    def points
      wins * 2 + ties
    end

    def run_differential
      runs_scored - runs_allowed
    end

    def games_played
      wins + losses + ties
    end

    def runs_allowed_average
      return 0 if games_played.zero?
      (runs_allowed / games_played.to_f).round(2)
    end

    def runs_scored_average
      return 0 if games_played.zero?
      (runs_scored / games_played.to_f).round(2)
    end

    def wins_losses_ties
      "#{wins}-#{losses}-#{ties}"
    end
  end
end