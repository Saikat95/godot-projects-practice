extends Node2D

onready var particles = $Particles2D

func _ready() -> void:
	particles.emitting = true;

func _on_Timer_timeout() -> void:
	particles.queue_free();
