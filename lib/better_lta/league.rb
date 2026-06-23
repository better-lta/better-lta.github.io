module BetterLTA
  class League
    A_NAMES = [
      "Belmont/Watertown",
      "Billerica",
      "Brookline",
      "Cambridge",
      "Dracut",
      "Everett",
      "Medford",
      "Newton",
      "Waltham",
      "Wilmington",
      "Winchester",
      "Woburn",
    ]

    B_ELITE_NAMES = [
      "Belmont",
      "Billerica",
      "Brookline",
      "Cambridge",
      "Concord-Carlisle",
      "Lincoln-Sudbury",
      "Lowell Red",
      "Melrose",
      "Reading Red",
      "Stoneham",
      "Triton",
      "Waltham",
    ]

    B_SELECT_NAMES = [
      "Andover",
      "Burlington",
      "Georgetown",
      "Lexington",
      "Lowell Black",
      "Natick",
      "North End",
      "Reading Black",
      "Wayland",
      "Winchester",
    ]

    C_ELITE_NAMES = [
      "Arlington",
      "Ashland",
      "Billerica",
      "Boston",
      "Brookline",
      "Cambridge",
      "Chelmsford",
      "Lowell",
      "Natick",
      "Needham",
      "Reading Red",
      "Winchester",
    ]

    C_SELECT_NAMES = [
      "Acton Boxboro",
      "Andover",
      "CC/Lexington",
      "Melrose",
      "North End",
      "Reading Black",
      "Waltham",
      "Wayland",
      "Wilmington",
    ]

    def initialize
      a_teams = A_NAMES.map { |name| Team.new(name: name) }
      a_conference = Conference.new(name: "A Division", teams: a_teams)
      @a_division = Division.new(name: "A", conferences: [a_conference])

      b_elite_teams = B_ELITE_NAMES.map { |name| Team.new(name: name) }
      b_select_teams = B_SELECT_NAMES.map { |name| Team.new(name: name) }
      b_elite_conference = Conference.new(name: "Elite", teams: b_elite_teams)
      b_select_conference = Conference.new(name: "Select", teams: b_select_teams)
      @b_division = Division.new(name: "B", conferences: [b_elite_conference, b_select_conference])

      c_elite_teams = C_ELITE_NAMES.map { |name| Team.new(name: name) }
      c_select_teams = C_SELECT_NAMES.map { |name| Team.new(name: name) }
      c_elite_conference = Conference.new(name: "Elite", teams: c_elite_teams)
      c_select_conference = Conference.new(name: "Select", teams: c_select_teams)
      @c_division = Division.new(name: "C", conferences: [c_elite_conference, c_select_conference])
    end

    def divisions
      [@a_division, @b_division, @c_division]
    end
  end
end
