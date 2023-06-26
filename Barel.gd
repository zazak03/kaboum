extends Node2D

@export var force = 10
@export var vie:float = 1
var game_playing = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func exploding(delay = 1):
	await get_tree().create_timer(delay).timeout # waits for 1 second
	print("exploding")
	var largeur_area2D = $Barrel/exploding_area/CollisionShape2D.shape.radius
	for debris in $Barrel/exploding_area.get_overlapping_bodies():
		if "debris" in debris.get_groups():
			var direction = (debris.global_position - $Barrel.global_position)
			var puissance_de_propulsage = (largeur_area2D - $Barrel.global_position.distance_to(debris.global_position)) * force
			debris.apply_impulse(direction.normalized() * puissance_de_propulsage)
			get_tree().root.get_node("home").Score += int(puissance_de_propulsage/4)
	hide()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_tree().root.get_node("home").game_is_playing:
		for body in $Barrel/hitbox.get_overlapping_bodies():
			if "debris" in body.get_groups():
				vie -= 1
				if vie <= 0:
					exploding(0)

