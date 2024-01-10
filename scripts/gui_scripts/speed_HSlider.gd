extends HSlider


func _ready():
		connect("value_changed", Callable(self, "change_speed"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func change_speed(val):
	print("changing speed")
	#get_tree().get_current_scene().get_node("Camera3D").max_speed.x = val
	#get_tree().get_current_scene().get_node("Camera3D").max_speed.y = val
	#get_tree().get_current_scene().get_node("Camera3D").max_speed.z = val
	
