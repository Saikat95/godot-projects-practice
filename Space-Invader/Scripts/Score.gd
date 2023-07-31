extends Node

func _process(delta: float) -> void:
	$Label.text = "Score " + str(PlayerData.score);
