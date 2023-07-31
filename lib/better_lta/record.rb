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

    def differential
      runs_scored - runs_allowed
    end
  end
end