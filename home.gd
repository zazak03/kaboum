extends Node2D

var picked:Node2D
var barrel_position
var radius = 16
var game_is_playing = false
@export var number_of_barrel:int = 3
@export var number_of_random_debris:int = 30
var Score = 0

@onready var barrel_scene = preload("res://barrel.tscn")
@onready var debri_scene = preload("res://debris.tscn")
@onready var big_debri_scene = preload("res://gros_debris.tscn")
var barrel
var debri
var big_debri

# Called when the node enters the scene tree for the first time.
func _ready():
	_on_reset_pressed()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	$Ui/Score.text = "Score : "+str(Score)
	
	for barrel in get_node("barrels").get_children():
		
		if barrel.position.x - radius <= get_global_mouse_position().x and get_global_mouse_position().x <= barrel.position.x + radius and barrel.position.y - radius <= get_global_mouse_position().y and get_global_mouse_position().y <= barrel.position.y + radius :
			if Input.is_action_just_pressed("click"):
				picked = barrel
				barrel.get_node("mouse_collision").disabled = true
		
		if picked != null:
			picked.position=get_global_mouse_position()
			if Input.is_action_just_released("click"):
				picked = null
				barrel.get_node("mouse_collision").disabled = false


func _on_button_pressed():
	game_is_playing = true
	$barrels.get_child(0).exploding()


func _on_reset_pressed():
	number_of_barrel = $Ui/HSlider.value
	number_of_random_debris = $Ui/HSlider2.value
	
	game_is_playing = false
	var decalage = [0,0]
	for old_barrel in $barrels.get_children():
		old_barrel.free()
			
	for old_debri in $debris_list.get_children():
		old_debri.free()
	
	for i in range(number_of_barrel):
		barrel = barrel_scene.instantiate()
		barrel.position = Vector2(1000+decalage[0],120+decalage[1])
		decalage[0] += 50
		if decalage[0]%150==0:
			decalage[1]+=50
			decalage[0]=0
		
		barrel.force = $Ui/HSlider3.value
		get_node("barrels").add_child(barrel)
	
	for i in range(number_of_random_debris):
		debri = debri_scene.instantiate()
		debri.position = Vector2(randi_range(16,948),randi_range(80,630))
		get_node("debris_list").add_child(debri)
	
	for i in range(randi_range(2,5)):
		big_debri = big_debri_scene.instantiate()
		big_debri.position = Vector2(randi_range(16,948),randi_range(80,630))
		get_node("debris_list").add_child(big_debri)
	
	$barrels.get_child(0).modulate = Color8(215,99,255)
	
