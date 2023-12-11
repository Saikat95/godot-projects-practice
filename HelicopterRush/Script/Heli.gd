extends KinematicBody2D

var direction = Vector2(0,0);
var speed = 400.0;
var velocity = Vector2(0,0);
var current_ani = "" setget set_curent_ani;
var bullet = preload("res://Objects/Bullet.tscn");

func _ready() -> void:
	$body/bladeSwing.play("blade_swing");

func _process(delta: float) -> void:
	move();
	bullet_fire();

func move():
	var direction = input();
	velocity = direction * speed;
	move_and_slide(velocity);

func input() -> Vector2:
	direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up");
	#rotate(direction);
	move_ani(direction);
	return direction;

#rotate
func rotate(rot_direction):
	var body_angle = rad2deg(transform.get_rotation());
	#up key pressed
	if(rot_direction == Vector2(0,-1) && floor(body_angle) <= 0):
		if(rotation_degrees > -90):
			rotation_degrees = rad2deg(transform.get_rotation()) - 10;
	if(rot_direction == Vector2(0,-1) && floor(body_angle) >= -180):
		if(rotation_degrees < -90):
			rotation_degrees = rad2deg(transform.get_rotation()) + 10;
	
	#right key pressed
	if(rot_direction == Vector2(1,0) && floor(body_angle) >= -90):
			if(rotation_degrees < 10):
				rotation_degrees = rad2deg(transform.get_rotation()) + 10;
	if(rot_direction == Vector2(1,0) && floor(body_angle) <= 90):	
			if(rotation_degrees > 10):
				rotation_degrees = rad2deg(transform.get_rotation()) - 10;
	
	#left key pressed
	if(rot_direction == Vector2(-1,0) && floor(body_angle) >= 90):	
			if(rotation_degrees < 180):
				rotation_degrees = floor(rad2deg(transform.get_rotation()) + 10);
	if(rot_direction == Vector2(-1,0) && floor(body_angle) <= -90):	
			if(rotation_degrees > -180):
				rotation_degrees = floor(rad2deg(transform.get_rotation()) - 10);
	
	#down key pressed
	if(rot_direction == Vector2(0,1) && floor(body_angle) <= 180):	
			if(rotation_degrees > 90):
				rotation_degrees = (rad2deg(transform.get_rotation()) - 10);
	if(rot_direction == Vector2(0,1) && floor(body_angle) >= 0):	
			if(rotation_degrees < 90):
				rotation_degrees = (rad2deg(transform.get_rotation()) + 10);
		
#movement animation
func move_ani(direction):
	var ani = $body/rotate;
	if(direction == Vector2(0,1) && current_ani != "down"):
		ani.play("down")
		set_curent_ani(ani.current_animation);
	if(direction == Vector2(0,-1) && current_ani != "up"):
		ani.play("up");
		set_curent_ani(ani.current_animation);

	if(direction == Vector2(0,-1) && current_ani == "up_to_left"):
		ani.play("left_to_up");
		set_curent_ani(ani.current_animation);
	
	if(direction == Vector2(-1,0) && rad2deg(transform.get_rotation()) == 0):
		ani.play("right_to_left")
		set_curent_ani(ani.current_animation);

	if(direction == Vector2(-1,0) && (current_ani == "up_to_right" || current_ani == "down_to_right" || current_ani == "left_to_right")):
		ani.play("right_to_left")
		set_curent_ani(ani.current_animation);
	
	if(direction == Vector2(1,0) && (current_ani == "up_to_left" || current_ani == "down_to_left" || current_ani == "right_to_left")):
		ani.play("left_to_right")
		set_curent_ani(ani.current_animation);
	
	#right movement
	if(direction == Vector2(1,0) && current_ani != "right" && current_ani == "down"):
		ani.play("down_to_right");
		set_curent_ani(ani.current_animation);
	if(direction == Vector2(1,0) && current_ani != "right" && current_ani == "up"):
		ani.play("up_to_right");
		set_curent_ani(ani.current_animation);
	
	#left movement
	if(direction == Vector2(-1,0) && current_ani != "left" && current_ani == "down"):
		ani.play("down_to_left");
		set_curent_ani(ani.current_animation);
	if(direction == Vector2(-1,0) && current_ani != "left" && current_ani == "up"):
		ani.play("up_to_left");
		set_curent_ani(ani.current_animation);

func set_curent_ani(value):
	current_ani = value;

func bullet_fire():
	if(Input.is_action_just_pressed("ui_accept")):
		Music.fire.play();
		add_bullet();

func add_bullet():
	var bullet_ins = bullet.instance();
	var bullet_direction = input();
	
	if(bullet_direction.x == -1):
		bullet_ins.rotation_degrees = -180
	if(bullet_direction.x == 1):
		bullet_ins.rotation_degrees = 0;
	if(bullet_direction.y == -1):
		bullet_ins.rotation_degrees = -90;
	if(bullet_direction.y == 1):
		bullet_ins.rotation_degrees = 90;
	
	add_child(bullet_ins);
