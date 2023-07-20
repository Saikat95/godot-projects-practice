extends Node2D

export (String) var piece_color;
var move_tween
var matched = false;

func _ready():
	move_tween = get_node("Tween")
	
func move(target):
	move_tween.interpolate_property(self,"position",position, target, .3, Tween.TRANS_BOUNCE, Tween.EASE_IN_OUT)
	move_tween.start()
	
func dim():
	get_node("Sprite").modulate = Color(1,1,1,0.5)
