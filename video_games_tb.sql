video_games_tb = "CREATE TABLE video_games(
    id INTEGER NOT NULL UNIQUE PRIMARY KEY,
    name text NOT NULL,
    genre text,
    game_developer text,
    release_date date
);"

game_developers_tb = "CREATE TABLE game_developers(
    id INTEGER NOT NULL UNIQUE PRIMARY KEY,
    name text NOT NULL,
    address text,
    state text,
    city text,
    country text
);"

platforms_tb = "CREATE TABLE platforms(
    id INTEGER NOT NULL UNIQUE PRIMARY KEY,
    name text NOT NULL,
    company_id INTEGER,
    company text,
    release_date date,
    original_price numeric
);"

platforms_games_tb = "CREATE TABLE platforms_games (
    game_id INTEGER,
    platform_id INTEGER,
    platform_name TEXT,
    CONSTRAINT pk_platforms_games PRIMARY KEY (game_id, platform_id),
    FOREIGN KEY (game_id) REFERENCES video_games (id),
    FOREIGN KEY (platform_id) REFERENCES platforms(id));"

characters_tb = "CREATE TABLE characters(
    id INTEGER NOT NULL UNIQUE PRIMARY KEY,
    name text,
    birthday datetime,
    gender text,
    info text
);"

games_characters_tb = "CREATE TABLE games_characters(
    character_id INTEGER NOT NULL UNIQUE,
    character_name text,
    game_id INTEGER,
    CONSTRAINT pk_game_character PRIMARY KEY (game_id, character_id),
    FOREIGN KEY(game_id) REFERENCES video_games(id),
    FOREIGN KEY(character_id) REFERENCES characters(id)
);"

delete_rows = "DELETE FROM games_characters
WHERE character_id IS NULL;"

alter_table_platforms = "UPDATE platforms
SET release_date = DATE(release_date)
;"

alter_table_characters = "UPDATE characters
SET birthday = DATE(birthday)
;"


search_nathan = "SELECT * FROM characters
WHERE name = 'Nathan Drake'";

how_many_people = "SELECT count(info)
FROM characters
WHERE info LIKE '%Nathan Drake%';"


find_location = "SELECT address, state, city, country 
FROM game_developers 
WHERE name = (SELECT game_developer FROM video_games
WHERE id = (SELECT game_id FROM games_characters
WHERE character_name = 'Nathan Drake'));"

count_games_ca = " select count(video_games.name)
from game_developers
join video_games
on game_developers.name = video_games.game_developer 
where state = 'California'
group by state
order by count(video_games.name) desc;"

address =  "select game_developers.address, game_developers.city, game_developers.state, game_developers.country
from game_developers
join video_games
on game_developers.name = video_games.game_developer 
where state = 'California'
order by (video_games.release_date) DESC
Limit 1;
"