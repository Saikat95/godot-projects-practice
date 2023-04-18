extends KinematicBody2D

var velocity = Vector2.ZERO;
export var speed = 0;
var direction = Vector2.ZERO;

func _process(delta: float) -> void:
	direction = get_direction();
	velocity = direction * speed;
	velocity = move_and_slide(velocity);
	
	

func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),0
		);


