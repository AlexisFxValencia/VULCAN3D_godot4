extends HSlider


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("value_changed", Callable(self, "_set_y_size"))

func _set_y_size(val):
	get_tree().get_current_scene().get_node("Area3D/CollisionShape3D").shape.extents.y = 2*val
	get_tree().get_current_scene().get_node("Area3D/MFR").mesh.size.y = 4*val
	get_parent().get_node("b2g_label").update_b2g()
