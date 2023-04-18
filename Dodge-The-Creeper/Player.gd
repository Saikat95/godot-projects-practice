extends Area2D

signal hit
export var speed = 400;
var screen_size;
var target = Vector2(); #to hold the clicked position

func _ready():
	screen_size = get_viewport_rect().size;
	hide();

#this _input() function change target when touch event happens
func _input(event): 
	if event is InputEventScreenDrag: #event is entered
		target = event.position; #event is set to target

func _process(delta):
	var velocity = Vector2();
	
	#moving towards the target and stop when close
	if(position.distance_to(target) > 10):
		velocity = target - position;
	
	
#	if(Input.is_action_pressed("ui_right")):
#		velocity.x += 1;
#	if(Input.is_action_pressed("ui_left")):
#		velocity.x -= 1;
#	if(Input.is_action_pressed("ui_down")):
#		velocity.y += 1;
#	if(Input.is_action_pressed("ui_up")):
#		velocity.y -= 1;

	if(velocity.length() > 0):
		velocity = velocity.normalized() * speed;
		get_node("AnimatedSprite").play();
	else:
		get_node("AnimatedSprite").stop();
	
	position += velocity * delta;
	position.x = clamp(position.x, 0 , screen_size.x);
	position.y = clamp(position.y, 0 , screen_size.y);
	
	if(velocity.x != 0):
		if(velocity.x < 0):
			get_node("AnimatedSprite").flip_h = true;
		else:
			get_node("AnimatedSprite").flip_h = false;
		
	if(velocity.y != 0):
		if(velocity.y > 0):
			get_node("AnimatedSprite").flip_v = true;
		else:
			get_node("AnimatedSprite").flip_v = false;


func _on_Player_body_entered(body):
	hide();
	emit_signal("hit");
	get_node("CollisionShape2D").set_deferred("disabled",true);


func start(pos):
	position = pos;
	target = pos; #hold the beginning position in target
	show();
	get_node("CollisionShape2D").disabled = false;
