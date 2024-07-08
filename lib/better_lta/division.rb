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
      find_team(game.home_name)&.schedule_game(game)
      find_team(game.visitor_name)&.schedule_game(game)
    end

    def record_result(id:, home_score:, visitor_score:)
      game = games.find { |game| game.id == id }

      if game
        game.home_score = home_score
        game.visitor_score = visitor_score

        home_team = find_team(game.home_name)
        home_team.record_result(score: home_score, opponent_score: visitor_score)

        visitor_team = find_team(game.visitor_name)
        visitor_team.record_result(score: visitor_score, opponent_score: home_score)
      else
        puts "can't find game with id #{id}"
      end
    end

    def teams
      conferences.flat_map(&:teams)
    end

    private

    def find_team(name)
      teams.find { |team| team.name == name }
    end
  end
end
