tool
extends Area2D

export var next_scene:PackedScene;

onready var anim_play:AnimationPlayer = get_node("AnimationPlayer");

func _on_Portal_body_entered(body: Node) -> void:
	teleport();
	
func _get_configuration_warning() -> String:
	return "Next scene can't be empty" if not next_scene else "";
	

func teleport() -> void:
	anim_play.play("fade_out");
	yield(anim_play,"animation_finished");
	get_tree().change_scene_to(next_scene);



