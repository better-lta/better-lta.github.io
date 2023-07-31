module BetterLTA
  class Conference
    attr_reader :name, :teams

    def initialize(name:, teams:)
      @name = name
      @teams = teams
    end
  end
end