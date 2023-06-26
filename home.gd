extends Node2D

var picked = false
var barrel_position
var radius
# Called when the node enters the scene tree for the first time.
func _ready():
	radius = 16
	barrel_position = $Barrel.position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if barrel_position.x - radius <= get_global_mouse_position().x and get_global_mouse_position().x <= barrel_position.x + radius and barrel_position.y - radius <= get_global_mouse_position().y and get_global_mouse_position().y <= barrel_position.y + radius :
		print("inside")
		if Input.is_action_just_pressed("click"):
			picked = true
			print("picked")
	if picked:
		if Input.is_action_just_released("click"):
			picked = false
		$Barrel.position=get_global_mouse_position()



func _on_button_pressed():
	$Barrel.exploding()
