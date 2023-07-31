module BetterLTA
  class Division
    attr_reader :name, :conferences

    def initialize(name:, conferences:)
      @name = name
      @conferences = conferences
      @games = []
    end

    def games
      @games.sort_by(&:date_time)
    end

    def scores_file
      "data/#{name}-scores.csv"
    end
    
    def schedule_file
      "data/#{name}-schedule.csv"
    end

    def schedule_game(game)
      @games << game
    end

    def record_result(id:, home_score:, visitor_score:)
      game = games.find { |game| game.id == id }
      game.home_score = home_score
      game.visitor_score = visitor_score

      puts game.home_name
      home_team = find_team(game.home_name)
      home_team.record_result(score: home_score, opponent_score: visitor_score)

      puts game.visitor_name
      visitor_team = find_team(game.visitor_name)
      visitor_team.record_result(score: visitor_score, opponent_score: home_score)
    end

    private

    def find_team(name)
      conferences.flat_map(&:teams).find { |team| team.name == name }
    end
  end
end