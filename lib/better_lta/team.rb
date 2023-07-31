module BetterLTA
  class Team
    attr_reader :name, :record

    def initialize(name:)
      @name = name
      @record = Record.new
      @games = []
    end

    def games
      @games.sort_by(&:date_time)
    end

    def schedule_game(game)
      @games << game
    end

    def record_result(score:, opponent_score:)
      record.record_result(score: score, opponent_score: opponent_score)
    end
  end
end