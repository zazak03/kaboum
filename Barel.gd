extends Node2D

@export var force = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func exploding():
	await get_tree().create_timer(1).timeout # waits for 1 second
	print("exploding")
	var largeur_area2D = $Barrel/Area2D/CollisionShape2D.shape.radius
	for debris in $Barrel/Area2D.get_overlapping_bodies():
		var direction = (debris.global_position - $Barrel.global_position)
		debris.apply_impulse(direction.normalized() * (largeur_area2D - $Barrel.global_position.distance_to(debris.global_position)) * force)
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
