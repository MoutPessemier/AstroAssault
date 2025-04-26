extends Serialisable


func serialise() -> Dictionary:
	var data = super.serialise()
	
	return data

func deserialise(data: Dictionary) -> void:
	super.deserialise(data)
