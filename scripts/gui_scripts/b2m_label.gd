extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	update_b2m()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func update_b2m():
	set_text("B2m = " + str(get_tree().get_current_scene().get_node("Area3D").b2m))
