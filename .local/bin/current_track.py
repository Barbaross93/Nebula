#!/usr/bin/python

import spotipy
import spotipy.util as util
import json

username = "{YOUR_USERNAME}"
scope = "user-read-currently-playing"
# scope = 'user-read-playback-state'
# works as well

token = util.prompt_for_user_token(
    username,
    scope,
    client_id="{YOUR_ID}",
    client_secret="{YOUR_SECRET}",
    redirect_uri="{YOUR_REDIRECT}",
)

spotify = spotipy.Spotify(auth=token)
current_track = spotify.current_user_playing_track()

print(json.dumps(current_track))
