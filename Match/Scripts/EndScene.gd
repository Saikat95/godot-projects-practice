extends Control

var end_score = 0;
var total_moves = 0;
var moves_left = 0;
var moves_used = 0;

func _ready() -> void:
	score_details(end_score);
	move_used(moves_left);

func _on_ReplayButton_pressed() -> void:
	Music.click_sound();
	get_tree().change_scene("res://Scene/Main.tscn");
	
func score_details(var score):
	end_score = score;
	$PopBox/EndScore.text = "Score: " + String(end_score);

func move_initial(var total_move):
	total_moves = total_move;

func move_used(var move_left):
	moves_left = move_left;
	moves_used = total_moves - moves_left
	$PopBox/EndMove.text = "Moves: " + String(moves_used);
