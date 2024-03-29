extends Area3D

var sigma_s_micro = 145.0
var sigma_c_micro = 50.0
var sigma_f_micro = 185.0
var atomic_density = 9.48e20
var nu_bar = 2
var b2m = 0
var b2g = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	#connect("body_entered", Callable(self, "_on_Area_body_entered"))
	compute_b2m()
	compute_b2g()


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

func compute_b2m():	
	var sigma_total_macro = (sigma_s_micro + sigma_c_micro + sigma_f_micro)*atomic_density*pow(10, -24)
	var D = 1 / (3 * sigma_total_macro)
	b2m = (nu_bar*sigma_f_micro - sigma_c_micro)/D

func compute_b2g():
	var vector = get_node("CollisionShape3D").shape.extents
	b2g = pow(PI/vector.x,2) + pow(PI/vector.y,2) + pow(PI/vector.z,2)

