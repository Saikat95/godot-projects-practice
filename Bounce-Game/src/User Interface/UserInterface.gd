extends Control

onready var scene_tree: = get_tree();
onready var pause_overlay: ColorRect = get_node("PauseOverlay/Overlay");
onready var score = get_node("Score");


var can_click = true;


func _ready() -> void:
	PlayerData.connect("score_updated", self, "player_score");
	PlayerData.connect("death_updated",self, "player_death");
	player_score();

func player_score() -> void:
	score.text = "Score: %s" % PlayerData.score;

func player_death() -> void:
	self.paused = true;
	$PauseOverlay/Overlay/Label.text = "You Died";
	$PauseOverlay/Overlay/Menu/ResumeButton.visible = false;
	if(can_click):
		can_click = false;


var paused: = false setget set_paused

func set_paused(value: bool) -> void:
	paused = value;
	scene_tree.paused = value;
	pause_overlay.visible = value;

func _unhandled_key_input(event: InputEventKey) -> void:
	if(can_click):
		if event.is_action_pressed("pause"):
			self.paused = not paused
			#scene_tree.set_input_as_handled();
