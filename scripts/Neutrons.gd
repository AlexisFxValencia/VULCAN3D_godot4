extends Node3D
@export var neutron_scene : PackedScene = preload("res://scenes/Neutron.tscn")

enum Reaction {SCATTER, CAPTURE, FISSION}
var reflexions_activated = false
var on_pause = false
const NB_NEUTRONS_INIT = 500
var myneutrons = []


func _ready():
	for i in range(NB_NEUTRONS_INIT):		
		var neutron = neutron_scene.instantiate()  
		myneutrons.append(neutron) 
		neutron.active = false
		neutron.visible = false
		add_child(neutron)


func add_neutron_init():	
	var scene = get_tree().get_current_scene()
	var x = int(scene.get_node("Control/Panel/VBoxContainer/sources/x_source").text)
	var y = int(scene.get_node("Control/Panel/VBoxContainer/sources/y_source").text)
	var z = int(scene.get_node("Control/Panel/VBoxContainer/sources/z_source").text)
	var nb_source = int(scene.get_node("Control/Panel/VBoxContainer/sources/nb_source").text)
	for i in range(nb_source):
		myneutrons[i].active = true
		myneutrons[i].visible = true
		myneutrons[i].transform.origin = Vector3(x, y, z)
		myneutrons[i].old_position = Vector3(x, y, z)
		myneutrons[i].set_random_velocity()
		


func _update_label():
	var local_nb = 0
	for neutron in myneutrons:
		if neutron.active:
			local_nb += 1
	var text = "Number of neutrons " + str(local_nb)
	get_node("/root/Main/Control/Panel/VBoxContainer/minimal_VBoxContainer/nb_neutrons_label").set_text(text)	
	

func compute_nb_to_generate(nu_bar):
	var nb_generated_neutrons = 0
	var borne_inf = floor(nu_bar)
	if (borne_inf + randf() < nu_bar):
		nb_generated_neutrons = borne_inf
	else:
		nb_generated_neutrons = ceil(nu_bar) - 1
	return nb_generated_neutrons
	
func add_nu_neutrons(nu_bar, old_position):
	var nb_generated_neutrons = compute_nb_to_generate(nu_bar)	
	var nb_added = 0
	for neutron in myneutrons:
		if (nb_added < nb_generated_neutrons):
			if (neutron.active == false):
				neutron.active = true
				neutron.visible = true
				neutron.transform.origin = old_position
				neutron.set_random_velocity()
				nb_added += 1
		else:
			break

func _process(delta):	
	if not(on_pause):
		for neutron in myneutrons:
			if neutron.active:				
				var distance = neutron.transform.origin.distance_squared_to(neutron.old_position)
				if neutron.in_a_volume and distance > neutron.mean_free_path:
					neutron.old_position = neutron.transform.origin
					neutron.compute_one_reaction()
					if (neutron.last_reaction == Reaction.FISSION):
						add_nu_neutrons(neutron.nu_bar, neutron.old_position)
						pass
				if reflexions_activated:
					neutron.rebound_on_walls()
					pass
				else:
					neutron.deactivate_fled_neutron()
					pass
				neutron.move(delta)


		
		_update_label()

