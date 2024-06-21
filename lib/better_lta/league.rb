module BetterLTA
  class League
    A_NAMES = [
      "Arlington",
      "Belmont/Watertown",
      "Billerica",
      "Brookline",
      "Cambridge",
      "Haverhill",
      "Jamaica Plain",
      "Medford",
      "Newton",
      "Waltham",
      "Woburn",
    ]

    B_ELITE_NAMES = [
      "Andover",
      "Arlington",
      "Bedford-Concord",
      "Billerica",
      "Brookline",
      "Cambridge",
      "Lincoln Sudbury",
      "Marblehead",
      "Medford",
      "Reading Black",
      "Reading Red",
      "Waltham",
    ]

    B_SELECT_NAMES = [
      "Acton-Boxboro",
      "Belmont",
      "Chelmsford Maroon",
      "Chelmsford White",
      "Hudson",
      "Lexington",
      "Maynard/Stow",
      "Melrose",
      "North Andover",
      "North End",
      "Reading White",
      "Wayland",
    ]

    C_ELITE_NAMES = [
      "Arlington",
      "Lincoln Sudbury",
      "Lowell",
      "Marblehead",
      "Stoneham",
      "Cambridge",
      "Winchester",
      "Andover",
      "Chelmsford",
      "Reading Red",
      "Newburyport",
    ]

    C_SELECT_NAMES = [
      "Belmont",
      "Billerica",
      "Melrose",
      "Natick",
      "New/Lex/Nor",
      "Newton",
      "Waltham",
      "Wayland",
      "Winthrop",
      "Woburn",
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
