extends HSlider

@export var bus_name: String

var bus_index: int

func _ready() -> void:
	bus_index = AudioServer.get_bus_index(bus_name)
	value = db_to_linear(AudioServer.get_bus_volume_db(bus_index))
	value_changed.connect(_on_value_changed)
	mouse_exited.connect(_on_mouse_exit_slider)

func _on_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))

func _on_mouse_exit_slider() -> void:
	# TODO: Save sound settings between sessions 
	self.release_focus()
