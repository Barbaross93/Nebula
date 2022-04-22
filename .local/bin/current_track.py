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
    client_id="3a734da283924fbdb363bdd093fb8450",
    client_secret="4bd6b5a402444863b1367e57d7bc1f2e",
    redirect_uri="http://localhost:8888/callback",
)

spotify = spotipy.Spotify(auth=token)
current_track = spotify.current_user_playing_track()

print(json.dumps(current_track))
