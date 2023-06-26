extends RigidBody2D

@export var enfants = 2

@onready var petit_debris = load("res://debris.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func explosion(radius,position_barel,force):
	$Sprite2D.hide()
	$CollisionShape2D.hide()
	for i in range(enfants):
		var instance = petit_debris.instantiate()
		add_child(instance)
		instance.global_position = global_position
		instance.explosion(radius,position_barel + Vector2(randi_range(-10,10),randi_range(-10,10)),force)

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	get_tree().root.get_node("home").Score += int(linear_velocity.length()/100)
	pass
