load("cache.star", "cache")
load("encoding/base64.star", "base64")
load("encoding/json.star", "json")
load("http.star", "http")
load("render.star", "render")
load("schema.star", "schema")
load("time.star", "time")

SPORT = "basketball"
LEAGUE = "nba"
NBA_URL = "https://site.api.espn.com/apis/site/v2/sports/" + SPORT + "/" + LEAGUE + "/scoreboard"


def main():
    rep = http.get(NBA_URL)
    if rep.status_code != 200:
        fail("Coindesk request failed with status %d", rep.status_code)

    events = rep.json()["events"]
    matchups = []
    for event in events:
        matchups.append(
            render.Text("%s" % event["shortName"])
        )
    

    return render.Root(
        delay = 2000,
        child = render.Box(
            child = render.Animation(
                children = matchups,
            ),
        ),
    )