require "csv"
require "nokogiri"
require 'open-uri'

module BetterLTA
  class Downloader
    def self.fetch_all
      new("A", schedule: "schedule-a", scores: "divisionascores").fetch
      new("B", schedule: "b-division-schedule", scores: "division-b-score").fetch
      new("C", schedule: "c-division-schedule", scores: "division-c-score").fetch
    end

    def initialize(division, schedule:, scores:)
      @division = division
      @schedule_path = schedule
      @scores_path = scores
    end

    def fetch
      fetch_schedule
      fetch_scores
    end

    private

    attr_reader :division, :schedule_path, :scores_path

    def fetch_schedule
      table_to_csv(
        url: "https://ltasbaseball.com/#{schedule_path}",
        filename: "data/#{division}-schedule.csv"
      )
    end

    def fetch_scores
      table_to_csv(
        url: "https://ltasbaseball.com/#{scores_path}",
        filename: "data/#{division}-scores.csv"
      )
    end

    def table_to_csv(url:, filename:)
      schedule = Nokogiri::HTML(URI.open(url)).css("tbody").first
      CSV.open(filename, "wb") do |csv|
        schedule.css("tr").each do |row|
          csv << row.css("td").map(&:text)
        end
      end
    end
  end
end
