extends Node2D

var picked:Node2D
var barrel_position
var radius = 16
var game_is_playing = false
@export var number_of_barrel:int
@export var number_of_random_debris:int

var Score:int

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	for barrel in get_node("barrels").get_children():
		
		if barrel.position.x - radius <= get_global_mouse_position().x and get_global_mouse_position().x <= barrel.position.x + radius and barrel.position.y - radius <= get_global_mouse_position().y and get_global_mouse_position().y <= barrel.position.y + radius :
			if Input.is_action_just_pressed("click"):picked = barrel
		
		if picked != null:
			picked.position=get_global_mouse_position()
			if Input.is_action_just_released("click"):picked = null


func _on_button_pressed():
	game_is_playing = true
	$barrels/barrel_explose_debut.exploding()
