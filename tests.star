# Import necessary modules
import requests
import json

# Function to fetch the recent Celtics score
def get_celtics_score():
    url = "https://site.api.espn.com/apis/site/v2/sports/basketball/nba/scoreboard"
    params = {
        "dates": "latest",
        "limit": 1
    }
    response = requests.get(url, params=params)
    data = response.json()
    if response.status_code == 200:
        try:
            game = data["events"][0]
            home_team = game["competitions"][0]["competitors"][0]["team"]["displayName"]
            home_score = game["competitions"][0]["competitors"][0]["score"]
            away_team = game["competitions"][0]["competitors"][1]["team"]["displayName"]
            away_score = game["competitions"][0]["competitors"][1]["score"]
            return f"{home_team} {home_score} - {away_team} {away_score}"
        except (KeyError, IndexError):
            return "No recent game found"
    else:
        return "Failed to fetch data"

# Main function to display the score
def main():
    celtics_score = get_celtics_score()
    display(celtics_score)

# Execute the main function
main()
