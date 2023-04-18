extends KinematicBody2D

onready var animatedSprite = $AnimatedSprite


var gravity = 0;
var jumpHeight = 0;
var velocity = Vector2.ZERO;
signal player_hit;

func game_start() -> void:
	animatedSprite.play("run");
	gravity = 900;
	jumpHeight = 400;

func _physics_process(delta) :
	if(Input.is_action_pressed("jump")) and is_on_floor():
		velocity.y -= jumpHeight;
		get_parent().get_node("Music").JumpSound()
	velocity.y += gravity * delta;
	velocity = move_and_slide(velocity, Vector2.UP)

func player_hit():
	queue_free();
	emit_signal("player_hit");
	get_parent().get_node("Music").HitSound()
	get_parent().get_node("Music/bgMusic").stop()
