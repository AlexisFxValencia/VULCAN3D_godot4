extends Control

var mouse_over = false
var mesh_selection = false

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("mouse_entered", Callable(self, "_panel_entered"))
	connect("mouse_exited", Callable(self, "_panel_exited"))
	connect_all_gui_nodes(get_child(0))


func connect_all_gui_nodes(node):
	for N in node.get_children():
		if N.get_child_count() > 0:
			#print("["+N.get_name()+"]")
			connect_all_gui_nodes(N)
		else:
			N.connect("mouse_entered", Callable(self, "_panel_entered"))
			N.connect("mouse_exited", Callable(self, "_panel_exited"))
			#print("- "+N.get_name())
