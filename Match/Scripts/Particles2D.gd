extends Particles2D


func _ready() -> void:
	Music.blast_sound();
	emitting = true;


func _on_Timer_timeout() -> void:
	queue_free();
