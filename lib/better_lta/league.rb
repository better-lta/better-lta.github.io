module BetterLTA
  class League
    A_NAMES = [
      "Acton-Boxborough",
      "Belmont/Watertown",
      "Billerica",
      "Brookline",
      "Cambridge",
      "Medford/North End",
      "Newton",
      "Reading Black",
      "Reading Red",
      "The Base",
      "Waltham",
      "Woburn",
    ]

    B_EAST_NAMES = [
      "Andover",
      "Brookline",
      "Cambridge",
      "Haverhill",
      "Marblehead",
      "Medford",
      "Melrose",
      "North Andover",
      "North End",
      "Reading Black",
      "Reading Red",
      "Winthrop",
    ]

    B_WEST_NAMES = [
      "Acton-Boxborough",
      "Bedford",
      "Belmont",
      "Billerica",
      "Chelmsford Black",
      "Chelmsford Maroon",
      "Jamaica Plain",
      "Lincoln-Sudbury",
      "Needham",
      "Waltham",
      "Wayland",
      "Winchester",
    ]

    C_EAST_NAMES = [
      "Arlington",
      "Brookline",
      "Cambridge",
      "Marblehead",
      "Maynard/Stow",
      "Melrose",
      "Reading Black",
      "Reading Red",
      "Winchester",
      "Winthrop",
      "Woburn",
    ]

    C_WEST_NAMES = [
      "Acton-Boxborough",
      "Andover",
      "Belmont",
      "Billerica",
      "Chelmsford",
      "Lincoln-Sudbury",
      "North Andover",
      "Waltham",
      "Wayland",
      "Wayland/Weston",
    ]
    
    def initialize
      a_teams = A_NAMES.map { |name| Team.new(name: name) }
      a_conference = Conference.new(name: "A Division", teams: a_teams)
      @a_division = Division.new(name: "A", conferences: [a_conference])

      b_east_teams = B_EAST_NAMES.map { |name| Team.new(name: name) }
      b_west_teams = B_WEST_NAMES.map { |name| Team.new(name: name) }
      b_east_conference = Conference.new(name: "East", teams: b_east_teams)
      b_west_conference = Conference.new(name: "West", teams: b_west_teams)
      @b_division = Division.new(name: "B", conferences: [b_east_conference, b_west_conference])

      c_east_teams = C_EAST_NAMES.map { |name| Team.new(name: name) }
      c_west_teams = C_WEST_NAMES.map { |name| Team.new(name: name) }
      c_east_conference = Conference.new(name: "East", teams: c_east_teams)
      c_west_conference = Conference.new(name: "West", teams: c_west_teams)
      @c_division = Division.new(name: "C", conferences: [c_east_conference, c_west_conference])
    end

    def divisions
      [@a_division, @b_division, @c_division]
    end
  end
end