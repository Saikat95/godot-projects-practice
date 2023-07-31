extends Area2D

func _on_Enemy_body_entered(body: Node) -> void:
	if(body.name != "Wall"):
		PlayerData.score += 10;
		queue_free()
		body.queue_free()
		$Destroy.play();
	else:
		PlayerData.health = 0;
		get_parent().remove_health(PlayerData.health);
		get_parent().game_over();
