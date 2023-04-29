extends Label

func _process(delta: float) -> void:
	score_display()


func score_display():
	text = String(Global.Score)
