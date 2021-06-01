#!/usr/bin/python

import spotipy
import spotipy.util as util
import json

username = "cullenrss"
scope = "user-read-currently-playing"
# scope = 'user-read-playback-state'
# works as well

token = util.prompt_for_user_token(
    username,
    scope,
    client_id="",
    client_secret="",
    redirect_uri="",
)

spotify = spotipy.Spotify(auth=token)
current_track = spotify.current_user_playing_track()

print(json.dumps(current_track))
