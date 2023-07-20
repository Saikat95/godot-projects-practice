extends Control

onready var score_label = $MarginContainer/score_label/Label
onready var move_count = $MarginContainer/move_count/Label
onready var game_timer_label = $MarginContainer/game_timer/Label

var current_score = 0;
var current_move_count = 0;
var initial_move_count;
export(int) var game_timer;

var timer_status = true;

func _ready() -> void:
	_on_Grid_update_score(current_score);
	#_on_Grid_update_move()
	_on_GameTimer_timeout()

func _process(delta: float) -> void:
	game_timer_label.text = String(game_timer);

func _on_Grid_update_score(updated_score) -> void:
	current_score += updated_score;
	score_label.text = String(current_score);

func _on_Grid_update_move(value = -1) -> void:
	current_move_count += value;
	move_count.text = String(current_move_count);
	if(current_move_count == 0):
		get_parent().get_node("Grid").game_over();
		get_parent().get_node("GameTimer").stop();
		get_parent().get_node("EndScene").score_details(current_score);
		get_parent().get_node("EndScene").move_used(current_move_count);

func _on_GameTimer_timeout() -> void:
	if(game_timer != 0 && timer_status):
		game_timer -= 1;
	if(game_timer == 0):
		get_parent().get_node("Grid").game_over();
		get_parent().get_node("GameTimer").stop();
		get_parent().get_node("EndScene").score_details(current_score);
		get_parent().get_node("EndScene").move_used(current_move_count);

func _on_Grid_timer_status_signal(status) -> void:
	timer_status = status;
