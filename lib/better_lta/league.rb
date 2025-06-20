module BetterLTA
  class League
    A_NAMES = [
      "Arlington",
      "Ayer-Shirley",
      "Belmont/Watertown",
      "Billerica",
      "Brookline",
      "Cambridge",
      "Everett",
      "Jamaica Plain",
      "Lowell",
      "Medford",
      "Newton",
      "Waltham",
      "Wellesley",
      "Wilmington",
      "Winchester",
      "Woburn",
    ]

    B_ELITE_NAMES = [
      "Arlington",
      "Bedford",
      "Billerica Green",
      "Cambridge Black",
      "Cambridge Gray",
      "Georgetown",
      "Lincoln-Sudbury",
      "Lynnfield",
      "North Andover",
      "Reading",
      "Waltham",
    ]

    B_SELECT_NAMES = [
      "Andover",
      "Belmont",
      "Billerica White",
      "Everett",
      "Maynard/Stow",
      "Medford",
      "Melrose",
      "Natick",
      "North End",
      "Pepperell",
      "Stoneham",
      "Wayland",
    ]

    C_NAMES = [
      "Acton-Boxboro",
      "Andover",
      "Arlington",
      "Belmont",
      "Brookline",
      "CC/Bedford",
      "Chelmsford",
      "Lincoln-Sudbury",
      "Lowell",
      "Lynnfield",
      "Melrose",
      "Newton",
      "Reading Black",
      "Reading Red",
      "Stoneham",
      "Waltham",
      "Wayland",
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

      c_teams = C_NAMES.map { |name| Team.new(name: name) }
      c_conference = Conference.new(name: "C Division", teams: c_teams)
      @c_division = Division.new(name: "C", conferences: [c_conference])
    end

    def divisions
      [@a_division, @b_division, @c_division]
    end
  end
end
