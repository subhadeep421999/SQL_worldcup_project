use college13;
select * from odi_worldcup2023_PlayerLevel;


-- Q.1  Top 10 Run Scorers in the Tournament
select player_name, team, sum(runs) as total_runs 
from ODI_worldcup2023_playerlevel
group by player_name, team
order by total_runs desc limit 10;



-- Q.2  Top 10 Bowlers by Total Wickets
select player_name, team, sum(wickets) as total_wickets
from ODI_worldcup2023_playerlevel
group by player_name, team
order by total_wickets limit 10;



-- Q.3  Average Strike Rate by Team
select team,round(avg(strike_rate),2) as avg_strike_rate
from ODI_worldcup2023_playerlevel
group by team order by avg_strike_rate desc;



-- Q.4  Player of the Match Frequency
select player_name, team, count(*) as times_player_of_match
from ODI_worldcup2023_playerlevel
where player_of_match =1
group by player_name, team 
order by times_player_of_match desc;



-- Q.5  Team-wise Total Runs and Wickets in the Tournament
select team, sum(runs) as total_team_runs, sum(wickets) as total_team_wickets
from ODI_worldcup2023_playerlevel
group by team order by total_team_runs desc;



-- Q.6  Best Bowling Economy by Players (Min 10 Overs Bowled)
select player_name, team, round(sum(runs_conceded) / sum(overs_bowled),2) as avg_economy
from odi_worldcup2023_playerlevel
where overs_bowled>=10
group by player_name, team
having sum(overs_bowled)> 10
order by avg_economy asc limit 10;



-- Q.7  Match-Wise Team Scores
select match_id, team, sum(runs) as team_total_score
from odi_worldcup2023_playerlevel
group by match_id, team
order by match_id;



-- Q.8  Top Performances: Players Who Scored 100+ Runs
select match_id, player_name,team, runs, strike_rate
from odi_worldcup2023_playerlevel
where runs >=100
order by runs desc;



-- Q.9  Rank Players by Average Runs using Window Function
select player_name, team, round(avg(runs),2) as avg_runs,
rank() over(order by avg(runs) desc) as rank_by_avg
from odi_worldcup2023_playerlevel
group by player_name, team;



-- Q.10  Find All Indian Players Who Took 3+ Wickets in Any Match
select Match_id, player_name, wickets, runs_conceded
from odi_worldcup2023_playerlevel
where team='India' and wickets >=3
order by match_id; 



-- Q11. Most Consistent Batsmen (Lowest Std Dev of Runs Across Matches)
select player_name, team, round(avg(runs),2) as avg_runs, round(stddev(runs),2) as runs_stddev
from odi_worldcup2023_playerlevel group by player_name, team
having count(match_id) >=3
order by runs_stddev asc, avg_runs desc limit 10;



-- Q12. Best All-Round Match Performances (High Runs + 3+ Wickets in Same Match)
select match_id, player_name, team, runs, wickets, (runs + ( wickets*25)) as impact_score
from odi_worldcup2023_playerlevel where runs >= 50 and wickets >= 3
order by impact_score desc limit 10;



-- Q13. Player Performance Trend — Cumulative Runs per Match
select player_name, team, match_id, runs, sum(runs) over(partition by player_name order by match_id) as cumulative_runs
from odi_worldcup2023_playerlevel where player_name ='Virat Kohli'
order by match_id;



-- Q14. Team Dominance — Win Percentage 
select team, count(*) as total_matches,
sum(case when result = 'win' then 1 else 0 end) as wins,
round(( sum( case when result = 'win' then 1 else 0 end) / count(*))*100,2) as win_percentage
from odi_worldcup2023_playerlevel group by team
order by win_percentage desc;



-- Q15. Impact Index — Weighted Score Combining Runs, Wickets, and Strike Rate
select player_name, team, round(sum(runs)*0.5 + sum(wickets)*25 + avg(strike_rate)*0.25, 2) as impact_index
from odi_worldcup2023_playerlevel
group by player_name, team
order by impact_index desc limit 10;




















































