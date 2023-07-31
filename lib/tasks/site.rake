namespace :site do
  desc "Generate the site"
  task :generate do
    BetterLTA::League.new.divisions.each do |division|
      CSV.foreach(division.schedule_file, headers: false) do |row|
        game = row_to_game(row)
        division.schedule_game(game)
      end

      CSV.foreach(division.scores_file, headers: false) do |row|
        division.record_result(
          id: row[0].sub("Game ", "").to_i,
          home_score: row[4].to_i,
          visitor_score: row[2].to_i
        )
      end

      if division.name == "C"
        division.conferences.each do |conference|
          puts "#{conference.name} Standings"

          conference.teams.sort_by { |team| [team.record.points] }.reverse.each do |team|
            puts "#{team.name}, #{team.record.wins}, #{team.record.losses}, #{team.record.ties}, #{team.record.runs_scored}, #{team.record.runs_allowed}, #{team.record.differential}, #{team.record.points}"
          end

          puts
        end
      end
    end
  end

  def row_to_game(row)
    id = row[0].sub("Game ", "").to_i
    date_time = DateTime.strptime("#{row[1]} #{row[3]}", "%m/%d/%Y %I:%M %p")
    visitor = row[4]
    home = row[5]
    location = row[6]
      
    BetterLTA::Game.new(
      id: id,
      date_time: date_time,
      visitor_name: visitor,
      home_name: home,
      location: location
    ) 
  end
end