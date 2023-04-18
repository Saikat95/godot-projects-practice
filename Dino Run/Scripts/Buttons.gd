extends Node

signal gameover
signal start
var bgSound = "res://Assests/bg.mp3"

func start_game() -> void:
	$Start.hide()
	
func show_gameover() -> void:
	$Restart.show()

func _on_Restart_pressed() -> void:
	print("Restart Pressed")
	emit_signal("gameover")
	get_tree().reload_current_scene()
	$Restart.hide()


func _on_Start_pressed() -> void:
	get_parent().get_node("Music").BGMusic()
	get_parent().get_node("Player").game_start()
	get_parent().get_node("Background").game_start()
	Global.score = 0;
