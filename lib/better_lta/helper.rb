module BetterLTA
  class Helper
    attr_accessor :active_page

    def initialize
      @active_page = nil
    end

    def active_class(link_name)
      if link_name.downcase == active_page.to_s.downcase
        "active"
      end
    end

    def standings_link(division)
      "/#{division.name.downcase}-standings.html"
    end
  end
end