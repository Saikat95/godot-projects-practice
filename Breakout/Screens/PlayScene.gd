extends Node2D

onready var heart = preload("res://Ojects/Heart.tscn");
onready var brick = preload("res://Ojects/Brick.tscn");
var brickNum = 52;
export var next_scene: PackedScene;

var score = PlayerData.score;

func _ready() -> void:
	heartBar();
	bricks();
	$Paddle/Sprite.frame = PlayerData.paddleFrame;
	$UserInterface/UI/Score.text = "Score: 0";
	PlayerData.connect("score_changed",self,"score_display");
	$UserInterface/UI/StartTimer.start();
	$UserInterface/UI/StartTimer.connect("timeout",self,"start_game");
	PlayerData.connect("no_health",self,"stop_game");

func score_display(value):
	score = value;
	$UserInterface/UI/Score.text = "Score: " + str(score);

func _process(delta: float) -> void:
	if(PlayerData.score == 520):
		$Ball.speed = 0;
		$Paddle.speed = 0;
		stop_game();

func heartBar():
	var heart_instance = heart.instance();
	heart_instance.position = Vector2(720,10);
	heart_instance.scale = Vector2(0.1,0.1);
	add_child(heart_instance);

func bricks():
	for i in range(13):

		#instance all the brick colors
		var yellow = brick.instance();
		var green = brick.instance();
		var blue = brick.instance();
		var red = brick.instance();

		#Set the position of the bricks
		yellow.position = Vector2(200+(50*i),140);
		green.position = Vector2(200+(50*i),190);
		blue.position = Vector2(200+(50*i),240);
		red.position = Vector2(200+(50*i),290);

		#Set the property of the brick(make the brick color visible)
		yellow.get_node("Brick/Yellow").visible = true;
		green.get_node("Brick/Green").visible = true;
		blue.get_node("Brick/Blue").visible = true;
		red.get_node("Brick/Red").visible = true;

		#Add the childs
		add_child(yellow);
		add_child(green);
		add_child(blue);
		add_child(red);
		

func _on_Ball_damage() -> void:
	PlayerData.health -= 1;
	Music.play_death_music();
	reset();

func reset():
	$Ball.position = Vector2(515,475);
	$Paddle.position = Vector2(515,505);

func start_game():
	$Paddle.speed = 1500;
	$UserInterface/UI/CountDown.visible = false;
	$UserInterface/UI/StartTimer.stop();
	$Ball.direction = Vector2(1,-1);


func stop_game():
	get_tree().change_scene_to(next_scene);


var paused: = false setget set_paused

func set_paused(value: bool) -> void:
	paused = value;
	get_tree().paused = value;

func _unhandled_key_input(event: InputEventKey) -> void:
	if event.is_action_pressed("ui_cancel"):
		self.paused = not paused

