module BetterLTA
  class Game
    attr_reader :id, :date_time, :visitor_name, :home_name, :location, :visitor_score, :home_score
    attr_writer :visitor_score, :home_score

    def initialize(id:, date_time:, visitor_name:, home_name:, location:, visitor_score: nil, home_score: nil)
      @id = id
      @date_time = date_time
      @visitor_name = visitor_name
      @home_name = home_name
      @location = location
      @visitor_score = visitor_score
      @home_score = home_score
    end

    def result(for_team:)
      return if visitor_score.nil? || home_score.nil?

      our_score = for_team.name == home_name ? home_score : visitor_score
      their_score = for_team.name == home_name ? visitor_score : home_score
      score = "#{our_score}-#{their_score}"

      if our_score > their_score
        "W #{score}"
      elsif our_score < their_score
        "L #{score}"
      else
        "T #{score}"
      end
    end

    def completed?
      !visitor_score.nil? && !home_score.nil?
    end

    def includes_team?(team)
      visitor_name == team.name || home_name == team.name
    end

    def won_by?(team)
      return false unless completed?

      if visitor_name == team.name
        visitor_score > home_score
      elsif home_name == team.name
        home_score > visitor_score
      else
        raise ArgumentError, "#{team.name} did not play in game #{id}"
      end
    end
  end
end