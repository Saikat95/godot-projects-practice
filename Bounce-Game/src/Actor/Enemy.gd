extends "res://src/Actor/Actor.gd"

export var score = 100;

func _ready() -> void:
	velocity.x = -speed.x;

#func _on_EnemyKill_body_entered(body: Node) -> void:


func _on_EnemyKill_area_entered(area: Area2D) -> void:
	if(area.global_position.y > get_node("EnemyKill").global_position.y):
		return
	die();


func _physics_process(delta: float) -> void:
	velocity.y += gravity*delta;
	if(is_on_wall()):
		velocity.x = velocity.x * -1;
	velocity.y = move_and_slide(velocity,FLOOR_NORMAL).y;
	

func die() -> void:
	PlayerData.score += score;
	queue_free();
