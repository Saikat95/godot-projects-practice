extends Node2D

func _on_Green_body_entered(body: Node) -> void:
	if(body.name == 'Ball'):
		PlayerData.score += 10;
	else:
		PlayerData.score += 0;


func _on_Blue_body_entered(body: Node) -> void:
	if(body.name == 'Ball'):
		PlayerData.score += 10;
	else:
		PlayerData.score += 0;


func _on_Red_body_entered(body: Node) -> void:
	if(body.name == 'Ball'):
		PlayerData.score += 20;
	else:
		PlayerData.score += 0;



func _on_Yellow_body_entered(body: Node) -> void:
	if(body.name == 'Ball'):
		PlayerData.score += 20;
	else:
		PlayerData.score += 0;
