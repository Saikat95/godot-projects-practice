extends Timer

var minTime = 1;
var maxTime = 3;

func _ready() -> void:
	randTime();
	connect("timeout",self,"randTime");

func _start():
	randTime().start();

func randTime():
	set_wait_time(rand_range(minTime,maxTime));


func _on_Player_player_hit() -> void:
	return
	
