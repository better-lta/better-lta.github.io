require "tilt"

module BetterLTA
  class Site
    SITE_PATH = File.join("site", "build")
    ASSET_PATH = File.join("site", "assets")
    TEMPLATE_PATH = File.join("site", "views")

    def self.clean
      new.clean
    end

    def self.generate
      new.generate
    end

    def initialize
      @layout = Tilt.new(File.join(TEMPLATE_PATH, "layout.erb"))
      @context = BetterLTA::Helper.new
    end

    def generate
      clean
      generate_index
      generate_standings
      generate_team_pages
      generate_assets
    end

    def clean
      FileUtils.rm_r(SITE_PATH, force: true)
      FileUtils.mkdir(SITE_PATH)
    end

    private

    attr_reader :layout, :context

    def generate_index
      template = Tilt.new(File.join(TEMPLATE_PATH, "index.erb"))
      league = BetterLTA.league

      index_page = layout.render(context, league: league) do
        template.render(context, divisions: league.divisions)
      end

      File.write(File.join(SITE_PATH, "index.html"), index_page)
    end

    def generate_standings
      template = Tilt.new(File.join(TEMPLATE_PATH, "standings.erb"))
      league = BetterLTA.league

      league.divisions.each do |division|
        standings_page = layout.render(context, league: league) do
          template.render(context, division: division)
        end

        File.write(File.join(SITE_PATH, "#{division.name.downcase}-standings.html"), standings_page)
      end
    end

    def generate_team_pages
      template = Tilt.new(File.join(TEMPLATE_PATH, "team.erb"))
      league = BetterLTA.league

      league.divisions.each do |division|
        division.teams.each do |team|
          team_page = layout.render(context, league: league) do
            template.render(context, division: division, team: team)
          end

          File.write(File.join(SITE_PATH, context.team_link(division, team)), team_page)
        end
      end
    end


    def generate_assets
      FileUtils.cp_r(ASSET_PATH, SITE_PATH)
    end
  end
end