extends Control

onready var scene: = get_tree();
onready var pause_overlay: ColorRect = get_node("Overlay");

func _on_ResumeButton_pressed() -> void:
	scene.paused = false;
	pause_overlay.visible = false;
