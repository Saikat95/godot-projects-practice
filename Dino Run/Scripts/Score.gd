extends Label

func _process(delta: float) -> void:
	text = 'SCORE : ' + String(Global.score);
