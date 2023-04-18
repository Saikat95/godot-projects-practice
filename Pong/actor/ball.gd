extends KinematicBody2D

var velocity = Vector2.ZERO;
export var speed = 300;
export var impulse = 20;

func _ready() -> void:
	randomize();
	#random_velocity();

func _physics_process(delta: float) -> void:
	var direction = get_direction();
	var velocity = direction * speed;
	#print("Speed: ",speed);
	#print(velocity);
	velocity =  move_and_slide(velocity);

func get_direction():
	if(global_position.y < 45 or global_position.y > 560):
		velocity.y = -velocity.y;
	return velocity;

func random_velocity() -> Vector2:
	var randomX = rand_range(1,10);
	if(randomX < 5):
		velocity.x = 1;
	else:
		velocity.x = -1;
	
	var randomY = rand_range(1,10);
	if(randomY < 5):
		velocity.y = 1;
	else:
		velocity.y = -1;
	
	return Vector2(velocity.x,velocity.y)


func _on_VisibilityNotifier2D_screen_exited() -> void:
	position.x = 512;
	position.y = 300;
	speed = 300;


func _on_Impulse_area_entered(area: Area2D) -> void:
	velocity.x = -velocity.x;
	speed = speed + impulse;

func stop():
	velocity.x = 0;
	velocity.y = 0;
	position.x = 512;
	position.y = 300;
	speed = 300;
