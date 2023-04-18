extends ParallaxBackground

var bgSpeed = 0;

func _physics_process(delta: float) -> void:
	scroll_base_offset -= Vector2(bgSpeed,0) * delta;

func game_start() -> void:
	bgSpeed = 700;

func _on_Player_player_hit() -> void:
	bgSpeed = 0;
