module BetterLTA
  class Conference
    attr_reader :name, :teams

    def initialize(name:, teams:)
      @name = name
      @teams = teams
    end

    def sorted_teams
      teams.sort_by { |team| team.record.points }.reverse
    end
  end
end