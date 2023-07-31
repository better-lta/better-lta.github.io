require_relative "better_lta/conference"
require_relative "better_lta/division"
require_relative "better_lta/downloader"
require_relative "better_lta/game"
require_relative "better_lta/helper"
require_relative "better_lta/league"
require_relative "better_lta/record"
require_relative "better_lta/site"
require_relative "better_lta/team"

module BetterLTA
  def self.league
    @league ||= League.new.tap do |league|
      league.divisions.each do |division|
        CSV.foreach(division.schedule_file, headers: false) do |row|
          game = BetterLTA::Game.new(
            id: row[0].sub("Game ", "").to_i,
            date_time: DateTime.strptime("#{row[1]} #{row[3]}", "%m/%d/%Y %I:%M %p"),
            visitor_name: row[4],
            home_name: row[5],
            location: row[6],
          )
          division.schedule_game(game)
        end
  
        CSV.foreach(division.scores_file, headers: false) do |row|
          division.record_result(
            id: row[0].sub("Game ", "").to_i,
            home_score: row[4].to_i,
            visitor_score: row[2].to_i
          )
        end
      end
    end
  end
end
