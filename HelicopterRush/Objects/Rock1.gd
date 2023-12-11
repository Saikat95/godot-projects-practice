extends StaticBody2D

func _on_Area2D_area_entered(area: Area2D) -> void:
	if(area.name == "RockDetect"):
		print("Bullet Free Area")
		area.queue_free();

func _on_Area2D_body_entered(body: Node) -> void:
	if(body.name == "Bullet"):
		print("Bullet Free Body");
		body.queue_free();
