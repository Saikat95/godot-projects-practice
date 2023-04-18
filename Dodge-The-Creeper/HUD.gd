extends CanvasLayer

signal start_game

func show_message(message):
	$MessageLable.text = message;
	$MessageLable.show();
	$MessageTimer.start();

func show_game_over():
	show_message("GAME OVER");
	yield($'MessageTimer',"timeout");
	$MessageLable.text = "DODGE \nTHE CREEPERS";
	$MessageLable.show();
	yield(get_tree().create_timer(1),"timeout");
	$StartButton.show();

func update_score(score):
	$ScoreLable.text = str(score);
	


func _on_StartButton_pressed():
	$StartButton.hide();
	emit_signal("start_game");
	


func _on_MessageTimer_timeout():
	$MessageLable.hide();
