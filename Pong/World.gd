extends Node2D

var leftScore;
var rightScore;
export var MAX_SCORE = 10;

onready var leftScoreLabel = $UI/UserInterface/LeftStickScore;
onready var rightScoreLabel = $UI/UserInterface/RightStickScore;

func _ready() -> void:
	leftScore = 0;
	rightScore = 0;

func _process(delta: float) -> void:
	leftScoreLabel.text = str(leftScore);
	rightScoreLabel.text = str(rightScore)
	is_win();

func _on_StickLeftWall_area_entered(area: Area2D) -> void:
	leftScore += 1;
	#leftScoreLabel.text = str(leftScore);

func _on_StickRightWall_area_entered(area: Area2D) -> void:
	rightScore += 1;
	#rightScoreLabel.text = str(rightScore)

func is_win():
	if(leftScore == MAX_SCORE):
		$UI/UserInterface/WinMessage.text = "Right Stick Has Won";
		post_win_menu();
		
	if(rightScore == MAX_SCORE):
		$UI/UserInterface/WinMessage.text = "Left Stick Has Won";
		post_win_menu();

func post_win_menu():
	$ball.stop();
	$UI/UserInterface/ReplayButton.visible = true;
	$UI/UserInterface/WinMessage.visible = true;


func new_game() -> void:
	print("Start Game");
	$ball.random_velocity();
	$UI/UserInterface/WinMessage.visible = false;
	leftScore = 0;
	rightScore = 0;
