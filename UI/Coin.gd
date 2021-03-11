extends Node2D

func _ready():
	z_index = 1000
	scale = Vector2.ZERO
	$Tween.interpolate_property(self, "scale", Vector2.ZERO, Vector2(1,1), 0.5, Tween.TRANS_BOUNCE, Tween.EASE_OUT)
	$Tween.start()
	$Tween.interpolate_property(self, "position", position, Vector2(85,15), 1.5, Tween.TRANS_EXPO, Tween.EASE_OUT,0.25)
	$Tween.start()
	$Tween.interpolate_property(self, "scale", Vector2(1,1), Vector2.ZERO, 1.5, Tween.TRANS_BOUNCE, Tween.EASE_OUT,0.6)
	$Tween.start()

func _physics_process(_delta):
	if not $Tween.is_active():
		queue_free()
