-- CREATE database sports_tournament_tracker;
-- USE  sports_tournament_tracker;

## STEP1:- Creating schemas

-- CREATE TABLE Teams (Team_id INT AUTO_INCREMENT PRIMARY KEY,
-- Team_name VARCHAR(50) NOT NULL);

-- CREATE TABLE Players (player_id INT AUTO_INCREMENT PRIMARY KEY,
-- player_name VARCHAR(50) NOT NULL,team_id INT,
-- FOREIGN KEY (team_id) REFERENCES Teams(team_id));

-- CREATE TABLE Matches (Match_id INT AUTO_INCREMENT PRIMARY KEY,
-- Team1_id INT,Team2_id INT,Team1_score INT,Team2_score INT,
-- Match_date DATE,FOREIGN KEY (Team1_id) REFERENCES Teams(Team_id),
-- FOREIGN KEY (Team2_id) REFERENCES Teams(Team_id));

-- CREATE TABLE Stats (Stat_id INT AUTO_INCREMENT PRIMARY KEY,
-- Match_id INT,Player_id INT,Points_score INT,Assists INT,
-- Rebounds INT,FOREIGN KEY (match_id) REFERENCES Matches(match_id),
-- FOREIGN KEY (player_id) REFERENCES Players(player_id));

## STEP2:-Inserting sample tournament data. 
-- INSERT INTO Teams (Team_name) VALUES ('Sharks'), ('Tigers');

-- INSERT INTO Players (Player_name, Team_id) VALUES 
-- ('Alice', 1), ('Bob', 1), ('Charlie', 2), ('David', 2);

-- INSERT INTO Matches (Team1_id, Team2_id, Team1_score, 
-- Team2_score, Match_date) VALUES
-- (1, 2, 78, 65, '2025-10-01'),
-- (2, 1, 80, 82, '2025-10-03');

-- INSERT INTO Stats (Match_id, Player_id, Points_score, 
-- Assists, Rebounds) VALUES
-- (1, 1, 20, 5, 7),
-- (1, 2, 15, 7, 4),
-- (1, 3, 25, 3, 8),
-- (1, 4, 10, 6, 3),
-- (2, 1, 22, 4, 5),
-- (2, 2, 18, 6, 6),
-- (2, 3, 30, 7, 10),
-- (2, 4, 17, 8, 5);

##STEP3:- for match results, player scores. 
-- SELECT m.Match_id, t1.Team_name AS Team1, t2.Team_name 
-- AS Team2, m.Team1_score, m.Team2_score, m.Match_date
-- FROM Matches m
-- JOIN Teams t1 ON m.Team1_id = t1.Team_id
-- JOIN Teams t2 ON m.Team2_id = t2.Team_id
-- ORDER BY m.Match_date;

-- SELECT p.Player_name, t.Team_name, s.Match_id, 
-- s.Points_score, s.Assists, s.Rebounds
-- FROM Stats s
-- JOIN Players p ON s.Player_id = p.Player_id
-- JOIN Teams t ON p.Team_id = t.Team_id
-- ORDER BY s.Match_id, p.Player_name;

##STEP4:- views for leaderboards and points tables. 

-- CREATE VIEW Leaderboard AS
-- SELECT p.Player_name, t.Team_name, SUM(s.points_score) AS total_points
-- FROM Stats s
-- JOIN Players p ON s.Player_id = p.Player_id
-- JOIN Teams t ON p.Team_id = t.Team_id
-- GROUP BY p.Player_id
-- ORDER BY total_points DESC;

-- CREATE VIEW TeamPoints AS
-- SELECT t.Team_name, SUM(CASE WHEN m.Team1_id = t.Team_id THEN m.team1_score ELSE m.team2_score END) AS total_team_points
-- FROM Teams t
-- LEFT JOIN Matches m ON (t.Team_id = m.Team1_id OR t.Team_id = m.team2_id)
-- GROUP BY t.Team_id
-- ORDER BY total_Team_points DESC;

##STEP5:- Use CTE for average player performance
-- WITH PlayerStats AS (
--     SELECT p.Player_name, t.Team_name, s.Points_score, s.Assists, s.Rebounds
--     FROM Stats s
--     JOIN Players p ON s.Player_id = p.Player_id
--     JOIN Teams t ON p.Team_id = t.Team_id
-- )
-- SELECT Player_name, Team_name,
--        AVG(points_score) AS Avg_points,
--        AVG(Assists) AS Avg_assists,
--        AVG(Rebounds) AS Avg_rebounds
-- FROM PlayerStats
-- GROUP BY Player_name, Team_name
-- ORDER BY Avg_points DESC;

##STEP6:- Export team performance reports
-- SELECT t.Team_name, 
--        COUNT(DISTINCT m.Match_id) AS Matches_played,
--        SUM(CASE WHEN m.Team1_id = t.Team_id THEN
--        m.Team1_score ELSE m.Team2_score END)
--        AS total_Points_score
-- FROM Teams t
-- LEFT JOIN Matches m ON (t.Team_id = m.Team1_id
-- OR t.Team_id = m.Team2_id)
-- GROUP BY t.Team_id
-- ORDER BY total_Points_score DESC;teampoints
