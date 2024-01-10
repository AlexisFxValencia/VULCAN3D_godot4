extends HSlider


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("value_changed", Callable(self, "_set_scattering"))


func _set_scattering(val):
	get_tree().get_current_scene().get_node("Area3D").sigma_s_micro = val
	get_tree().get_current_scene().get_node("Area3D").compute_b2m()
	get_parent().get_node("/root/Main/Control/Panel/VBoxContainer/geometry_VBoxContainer/b2m_label").update_b2m()
