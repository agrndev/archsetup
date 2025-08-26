#!/usr/bin/env python3

import gi
import json
import sys
from gi.repository import Playerctl, GLib
from gi.repository.Playerctl import Player

class PlayerManager:
    def __init__(self, selected_player=None, excluded_player=[]):
        self.manager = Playerctl.PlayerManager()
        self.loop = GLib.MainLoop()
        self.selected_player = selected_player
        self.excluded_player = excluded_player

        self.manager.connect("name-appeared", self.on_player_appeared)
        self.manager.connect("player-vanished", self.on_player_vanished)

        self.init_players()

    def init_players(self):
        for player in self.manager.props.player_names:
            if player.name not in self.excluded_player and (self.selected_player is None or self.selected_player == player.name):
                self.init_player(player)

    def run(self):
        self.loop.run()

    def init_player(self, player):
        player_instance = Playerctl.Player.new_from_name(player)
        player_instance.connect("playback-status", self.on_playback_status_changed)
        player_instance.connect("metadata", self.on_metadata_changed)
        self.manager.manage_player(player_instance)
        self.on_metadata_changed(player_instance, player_instance.props.metadata)

    def write_output(self, text, player):
        output = {
            "text": text,
            "class": "custom-" + player.props.player_name,
            "alt": player.props.player_name
        }
        sys.stdout.write(json.dumps(output) + "\n")
        sys.stdout.flush()

    def on_playback_status_changed(self, player, status):
        self.on_metadata_changed(player, player.props.metadata)

    def get_first_playing_player(self):
        for player in self.manager.props.players[::-1]:
            if player.props.status == "Playing":
                return player
        return None

    def show_most_important_player(self):
        current_player = self.get_first_playing_player()
        if current_player:
            self.on_metadata_changed(current_player, current_player.props.metadata)
        else:
            sys.stdout.write("\n")
            sys.stdout.flush()

    def on_metadata_changed(self, player, metadata):
        artist = player.get_artist()
        title = player.get_title().replace("&", "&amp;")
        track_info = f"{artist} - {title}" if artist and title else title

        if track_info:
            track_info = "   " + track_info if player.props.status == "Playing" else "   " + track_info
            current_playing = self.get_first_playing_player()
            if current_playing is None or current_playing.props.player_name == player.props.player_name:
                self.write_output(track_info, player)

    def on_player_appeared(self, _, player):
        if player.name not in self.excluded_player and (self.selected_player is None or player.name == self.selected_player):
            self.init_player(player)

    def on_player_vanished(self, _, player):
        self.show_most_important_player()

def main():
    player = PlayerManager()
    player.run()

if __name__ == "__main__":
    main()
