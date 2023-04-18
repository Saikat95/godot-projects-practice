extends  "res://actor/stick.gd"

func _process(delta: float) -> void:
	if(Input.is_action_pressed("w_up")):
		velocity.y = -speed;
	
	elif(Input.is_action_pressed("s_down")):
		velocity.y = speed;
		
	else:
		velocity.y = 0;
	
	move_and_slide(velocity);
