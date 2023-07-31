namespace :site do
  desc "Generate the site"
  task :generate do
    BetterLTA::Site.generate
  end
end
