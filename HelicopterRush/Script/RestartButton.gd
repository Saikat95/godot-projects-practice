extends TextureButton

onready var timer = get_node("/root/Ui/TimerContainer/Timer")

func _on_Restart_pressed() -> void:
	get_node("/root/PlayWindow/LooseScene").layer = -1;
	get_tree().change_scene("res://Scene/StartMenu.tscn");
	Global.life = 3;
	Global.time = 60;
	Ui_Script.enemy_no = 3;
	timer.text = str(Global.time);
	heart_reload();
	enemy_reload();
	pass

func enemy_reload():
	Ui_Script.enemy_no = 18;
	get_node("/root/Ui/EnemyCount/EnemyLeft").text = str(Ui_Script.enemy_no);

func heart_reload():
	Ui_Script.heart_no = 3;
	for i in range(1,Global.life+1):
		var string = "Heart" + str(i);
		get_node("/root/Ui/HeartContainer/"+string+"").visible = true;
