extends Node

# Audio
const MASTER_KEY = "Master"
const MUSIC_KEY = "Music"
const SFX_KEY = "SoundEffects"

var master_bus_index = AudioServer.get_bus_index(MASTER_KEY)
var music_bus_index = AudioServer.get_bus_index(MUSIC_KEY)
var sfx_bus_index = AudioServer.get_bus_index(SFX_KEY)

# Sprites
const SHIPWRECK_WIDTH = 60
const SHIP_Y_POSITION = 216
const TONGUE_BODY_HEIGHT = 5
