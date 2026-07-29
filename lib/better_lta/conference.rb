module BetterLTA
  class Conference
    attr_reader :name, :teams

    def initialize(name:, teams:)
      @name = name
      @teams = teams
    end

    def sorted_teams
      remaining_teams = teams.dup

      teams.map do
        next_team = next_seeded_team(remaining_teams)
        remaining_teams.delete(next_team)
        next_team
      end
    end

    private

    def next_seeded_team(remaining_teams)
      point_leaders = highest_by(remaining_teams) { |team| team.record.points }
      return point_leaders.first if point_leaders.one?

      percentage_leaders = highest_by(point_leaders) { |team| team.record.winning_percentage }
      return percentage_leaders.first if percentage_leaders.one?

      head_to_head_winner = percentage_leaders.find do |team|
        opponents = percentage_leaders - [team]
        opponents.all? { |opponent| team.swept?(opponent) }
      end
      return head_to_head_winner if head_to_head_winner

      runs_allowed_leaders = lowest_by(percentage_leaders) do |team|
        team.record.runs_allowed_per_game
      end

      runs_allowed_leaders.sample
    end

    def highest_by(contenders, &criterion)
      best_value = contenders.map(&criterion).max
      contenders.select { |contender| criterion.call(contender) == best_value }
    end

    def lowest_by(contenders, &criterion)
      best_value = contenders.map(&criterion).min
      contenders.select { |contender| criterion.call(contender) == best_value }
    end
  end
end