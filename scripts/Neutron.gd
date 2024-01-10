extends CharacterBody3D
@export var neutron_scene : PackedScene
@export var speed = 2.1
var my_velocity = Vector3.ZERO
var in_a_volume = false
var mean_free_path = 2.0
var old_position = Vector3.ZERO
var distance

var atomic_density
var nu_bar = 1.0
var sigma_s_micro = 1.0
var sigma_c_micro = 0.0
var sigma_f_micro = 0.0
var sigma_total_micro = 1.0
var proba_s = 1.0
var proba_c = 0.0
var proba_f = 0.0
var limits = 10

enum Reaction {SCATTER, CAPTURE, FISSION}
var last_reaction = Reaction.SCATTER

var active = false


func set_random_velocity():
	var radius = 5.0
	var theta = randf()*PI
	var phi = randf()*2*PI
	my_velocity.x = radius * sin(theta) * cos(phi)
	my_velocity.y = radius * sin(theta) * sin(phi)
	my_velocity.z = radius * cos(theta)
	

func _ready():
	set_random_velocity()

func move(delta):
	position += my_velocity * delta
	

func rebound_on_walls():
	if (transform.origin.x > limits):
		my_velocity.x = - abs(my_velocity.x)
	elif (transform.origin.x < - limits):
		my_velocity.x = abs(my_velocity.x)	
	if (transform.origin.y > 2*limits):
		my_velocity.y = - abs(my_velocity.y)
	elif (transform.origin.y < 0):
		my_velocity.y = abs(my_velocity.y)	
	if (transform.origin.z > limits):
		my_velocity.z = - abs(my_velocity.z)
	elif (transform.origin.z < -limits):
		my_velocity.z = abs(my_velocity.z)


func deactivate_fled_neutron():
	if (abs(transform.origin.x) > limits):
		active = false
		visible = false
	elif transform.origin.y > 2*limits or transform.origin.y < 0 :
		active = false
		visible = false
	elif (abs(transform.origin.z) > limits):
		active = false
		visible = false


func compute_probabilities():
	sigma_total_micro = sigma_s_micro + sigma_c_micro + sigma_f_micro
	proba_s = sigma_s_micro / sigma_total_micro
	proba_c = sigma_c_micro / sigma_total_micro
	proba_f = sigma_f_micro / sigma_total_micro

	
func compute_mean_free_path():
	var sigma_total_macro = atomic_density * sigma_total_micro * 1e-24
	var mean_free_path = 100 * (1 / sigma_total_macro)

	
func compute_one_reaction():
	var alea = randf()
	if (alea < proba_s):
		print("reaction : scatter")
		set_random_velocity() 
		last_reaction = Reaction.SCATTER
	elif (proba_s < alea && alea < proba_s + proba_c):
		print("reaction : capture")
		last_reaction = Reaction.CAPTURE
		active = false
		visible = false
	elif(proba_s + proba_c < alea && alea < 1.0):
		print("reaction : fission")
		set_random_velocity()
		last_reaction = Reaction.FISSION
		
		
	

