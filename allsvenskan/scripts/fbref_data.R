
# use worldfootballR library to access fbref data
library(worldfootballR)
library(readr)

# extract data on Allsvenskan 2021 matches 
match_results <- get_match_results('SWE', 'M', season_end_year = 2021, tier = '1st')

# extract team urls for Allsvenskan 2021
team_urls <- fb_teams_urls("https://fbref.com/en/comps/29/11002/2021-Allsvenskan-Stats")

# remove Helsingborg since it is a promotion play-off match
team_urls <- team_urls[-17]
match_results <- match_results[-c(241, 242),]

# save player stats for each team in Allsvenskan 2021
player_stats <- fb_team_player_stats(team_urls[1], 'standard')
for (i in 2:16){
  pl <- fb_team_player_stats(team_urls[i], 'standard')
  player_stats <- rbind(player_stats, pl)
}

# save extracted dataframes as .csv files
write_csv(player_stats, "player_stats.csv")
write_csv(match_results, "match_results.csv")
