extends Control

export var count = 3;

func _ready() -> void:
	$CountDown.text = str(count);
	$CountDownTimer.start();
	$CountDownTimer.connect("timeout",self,"read_countdown");
	

func read_countdown():
	count -= 1;
	if(count == 1):
		$CountDownTimer.stop();
	
	$CountDown.text = str(count);
