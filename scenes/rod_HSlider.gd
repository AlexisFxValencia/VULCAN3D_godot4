extends HSlider


func _ready():
	connect("value_changed", Callable(self, "_set_rod_height"))

func _set_rod_height(val):
	#get_node("/root/Main/Area3D_rod/CollisionShape3D").translation.z = val
	#get_node("/root/Main/Area3D_rod/MFR").translation.z = val
	#get_node("/root/Main/Area3D_rod").position.y = val
	get_node("/root/Main/Area3D_rod").position.y = val

