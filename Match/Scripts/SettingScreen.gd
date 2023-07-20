extends CanvasLayer

var master_bus = AudioServer.get_bus_index('Master')

func _on_HSlider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(master_bus,value)
	
	if(value < -29):
		AudioServer.set_bus_mute(master_bus,true)
	else:
		AudioServer.set_bus_mute(master_bus,false)

func play_music():
	$AudioStreamPlayer.play();
