namespace :data do
  desc "Refresh data from the LTA site"
  task :refresh do
    BetterLTA::Downloader.fetch_all
  end
end
