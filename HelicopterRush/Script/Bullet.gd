extends KinematicBody2D

var speed = 70;

func _physics_process(delta: float) -> void:
	position.x += speed;


func _on_Area2D_body_entered(body: Node) -> void:
	if(body.name == "Rock"):
		print("Bullet Free");
		queue_free();
