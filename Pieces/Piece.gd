extends Node2D

export (String) var color
var is_matched
var is_counted
var selected = false
var target_position = Vector2.ZERO
var default_modulate = Color(1,1,1,1)
var highlight = Color(1,0.8,0,1)

var fall_speed = 1.0
var move_speed = 1.0

onready var Coin = load("res://UI/Coin.tscn")

var dying = false
var was_selected = false

onready var Explosion = load("res://Congrats/Explosion.tscn")
onready var Congrats = load("res://Congrats/Sweet.tscn")

func _ready():
	randomize()
	

func _physics_process(_delta):
	if dying and not $Tween.is_active():
		queue_free()
	if not dying and target_position != Vector2.ZERO and not $Moving.is_active() and target_position != position:
		$Moving.interpolate_property(self, "position", position, target_position, move_speed, Tween.TRANS_BOUNCE, Tween.EASE_OUT)
		$Moving.start()
	if selected:
		$Selected.emitting = true
		$Select.show()
		z_index = 10
		was_selected = true
	else:
		$Selected.emitting = false
		$Select.hide()
		z_index = 1
		

func move_piece(change):
	target_position = position + change
	
func move_piece_to(change):
	target_position = change

func die():
	if was_selected:
		var congrats = Congrats.instance()
		congrats.position = position
		get_node("/root/Game/Congrats").add_child(congrats)
	was_selected = false
	
	dying = true
	var coin = Coin.instance()
	coin.position = position
	get_node("/root/Game/Effects").add_child(coin)
	var target_color = $Sprite.modulate
	target_color.s = 1
	target_color.h = randf()
	target_color.a = 0.25
	var fall_duration = randf()*fall_speed + 1
	var rotate_amount = (randi() % 1440) - 720

	var target_pos = position
	target_pos.y = 1100
	if randf() < 0.5:
		$Tween.interpolate_property(self, "position", position, target_pos, fall_duration, Tween.TRANS_CUBIC, Tween.EASE_IN)
		$Tween.start()
		$Tween.interpolate_property($Sprite, "modulate", $Sprite.modulate, target_color, fall_duration-0.25, Tween.TRANS_EXPO, Tween.EASE_IN)
		$Tween.start()
		$Tween.interpolate_property(self, "rotation_degrees", rotation_degrees, rotate_amount, fall_duration-0.25, Tween.TRANS_QUINT, Tween.EASE_IN)
		$Tween.start()
	else:
		fall_duration = 1
		$Tween.interpolate_property(self, "scale", scale, Vector2(5,5), fall_duration, Tween.TRANS_EXPO, Tween.EASE_OUT)
		$Tween.start()
		target_color.h = 0
		$Tween.interpolate_property($Sprite, "modulate", $Sprite.modulate, target_color, fall_duration-0.25, Tween.TRANS_EXPO, Tween.EASE_OUT)
		$Tween.start()

	if color == "Cow":
		get_node("/root/Game/Cow").playing = true
		
	if color == "Bear":
		get_node("/root/Game/Bear").playing = true
		
	if color == "Duck":
		get_node("/root/Game/Duck").playing = true
		
	if color == "Gorilla":
		get_node("/root/Game/Gorilla").playing = true
		
	if color == "Hippo":
		get_node("/root/Game/Hippo").playing = true
		
	if color == "Pig":
		get_node("/root/Game/Pig").playing = true
		
	if color == "Chick":
		get_node("/root/Game/Chick").playing = true
