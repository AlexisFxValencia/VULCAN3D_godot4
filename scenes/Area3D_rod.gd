extends Area3D

var sigma_s_micro = 50.0
var sigma_c_micro = 500.0
var sigma_f_micro = 0.0
var atomic_density = 9.48e20
var nu_bar = 1
var b2m = 0
var b2g = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	#connect("body_entered", Callable(self, "_on_Area_body_entered"))
	pass


func _on_Area_body_entered(body):
	body.in_a_volume = true
	body.sigma_s_micro = sigma_s_micro
	body.sigma_c_micro = sigma_c_micro
	body.sigma_f_micro = sigma_f_micro	
	body.atomic_density = atomic_density
	body.nu_bar = nu_bar
	body.compute_probabilities()
	body.compute_mean_free_path()


func _on_Area_body_exited(body):
	body.in_a_volume = false
