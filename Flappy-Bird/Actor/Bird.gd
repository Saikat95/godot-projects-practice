extends KinematicBody2D

var velocity = Vector2.ZERO;
onready var Pipe = preload("res://Objects/Pipes.tscn");
onready var Grass = preload("res://Objects/Ground.tscn");
var score  = 0;
export var gravity = 400;
signal hit;

func _process(delta: float) -> void:
	var direction = get_direction();
	bird_rotation(direction);
	velocity = gravity * direction;
	velocity = move_and_slide(velocity);

func get_direction() -> Vector2:
	return Vector2(
		0,
		-1.0 if Input.is_action_pressed("ui_up") else 1.0
	);

func bird_rotation(direction:Vector2):
	if(direction.y == -1.0):
		$bird.rotation = 18.0;
	else:
		$bird.rotation = 120.0;

func pipe_reset():
	var Pipe_instance = Pipe.instance();
	Pipe_instance.position = Vector2(1550,rand_range(200,400));
	get_parent().call_deferred("add_child",Pipe_instance);

func grass_reset():
	var grass_instance = Grass.instance();
	grass_instance.position = Vector2(500,575);
	get_parent().call_deferred("add_child",grass_instance);
	

func _on_Resetter_body_entered(body: Node) -> void:
	print(body.name);
	if(body.name == "Pipe"):
		body.queue_free();
		pipe_reset();
	if(body.name == "Grass"):
		body.queue_free();
		grass_reset();

func _on_Detect_body_entered(body: Node) -> void:
	if(body.name == "Pipe"):
		die();
	if(body.name == "Grass"):
		die();

func _on_Detect_area_entered(area: Area2D) -> void:
	if(area.name == "Score"):
		score += 1;
		get_parent().get_node("UserInerface/UI/Score").text = "Score: " + str(score);

func die():
	get_tree().paused = true;
	get_parent().get_node("GameSound").stop();
	get_parent().get_node("GameOverTwo");
	emit_signal("hit");
	
