# Copilot instructions for Better LTA

## Commands

Use Ruby 4.0.5 to match CI, then install dependencies with:

```sh
bundle install
```

Refresh scraped LTA data into `data/`:

```sh
bundle exec rake data:refresh
```

Generate the static site into `site/build/`:

```sh
bundle exec rake site:generate
```

Run the CI-like build locally with:

```sh
bundle exec rake data:refresh && bundle exec rake site:generate
```

There are no configured test or lint tasks in this repository.

## Architecture

This is a small Ruby static-site generator for a better Lou Tompkins All Star Baseball site. `Rakefile` loads `lib/better_lta.rb` and imports the two task files under `lib/tasks/`.

The data pipeline starts at `BetterLTA::Downloader.fetch_all`, which scrapes hard-coded LTA schedule and score pages for divisions A, B, and C using Nokogiri. It writes CSV files named `data/<division>-schedule.csv` and `data/<division>-scores.csv`.

`BetterLTA.league` builds an in-memory `League` from hard-coded division, conference, and team names in `lib/better_lta/league.rb`, then hydrates it from the generated CSVs. Schedule rows create `Game` objects and attach them to both the `Division` and matching `Team` objects. Score rows update the corresponding `Game` and each team's `Record`.

`BetterLTA::Site.generate` deletes and recreates `site/build/`, renders Tilt ERB templates from `site/views/` using `BetterLTA::Helper` as the template context, writes index/standings/team pages, and copies `site/assets/` into the build output. GitHub Actions refreshes data, generates the site, and publishes `site/build/` to the `gh-pages` branch.

## Codebase conventions

- Treat `site/build/` as generated output. Source templates live in `site/views/`; source CSS/JS lives in `site/assets/`.
- Treat `data/*.csv` as generated scraper output. `site:generate` expects those CSVs to exist, so run `data:refresh` first when `data/` only contains `.keep`.
- Division names are significant. `Division#scores_file`, `Division#schedule_file`, standings filenames, and team page links are all derived from names like `"A"`, `"B"`, and `"C"`.
- Team names in `League` must match scraped table text exactly after `strip`; mismatches prevent games and results from attaching to teams.
- CSV column positions are part of the integration contract with the scraped tables: schedule rows use game id, date, time, visitor, home, and location from indexes `0`, `1`, `3`, `4`, `5`, and `6`; score rows use game id, visitor score, and home score from indexes `0`, `2`, and `4`.
- Standings sort teams by `Record#points` descending, where points are `wins * 2 + ties`; there are no additional tiebreakers.
- Add template helper methods to `BetterLTA::Helper` when views need shared URL or navigation logic. The same helper instance is passed as the Tilt render context.
