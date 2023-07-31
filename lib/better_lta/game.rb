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
  end
end