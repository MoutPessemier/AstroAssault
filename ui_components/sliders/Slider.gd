extends HSlider

@export var bus_name: String

var bus_index: int

func _ready() -> void:
	bus_index = AudioServer.get_bus_index(bus_name)
	value = DataManager.music_stats.get_matching_bus(bus_name)
	tooltip_text = str(value * 100) + "%"
	value_changed.connect(_on_value_changed)
	mouse_exited.connect(_on_mouse_exit_slider)

func _on_value_changed(value: float) -> void:
	var db_value = linear_to_db(value)
	tooltip_text = str(value * 100) + "%"
	AudioServer.set_bus_volume_db(bus_index, db_value)
	DataManager.music_stats.update_bus_value(bus_name, value)
	

func _on_mouse_exit_slider() -> void:
	self.release_focus()
