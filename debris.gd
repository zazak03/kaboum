extends RigidBody2D




# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func explosion(radius,position_barel,force):
		var direction = (global_position - position_barel)
		var puissance_de_propulsage = (radius - position_barel.distance_to(global_position)) * force
		apply_impulse(direction.normalized() * puissance_de_propulsage)
		get_tree().root.get_node("home").Score += int(puissance_de_propulsage/4)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_tree().root.get_node("home").Score += int(linear_velocity.length()/100)
	pass
