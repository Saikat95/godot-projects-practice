extends CanvasLayer

var heart_no = 3;
var enemy_no = 18;

onready var enemy_count_node = get_node("/root/Ui/EnemyCount/EnemyLeft")

func _ready() -> void:
	enemy_count_node.text = str(enemy_no);


func heart_drop():
	var string = "Heart" + str(heart_no);
	get_node("/root/Ui/HeartContainer/"+string+"").visible = false;
	heart_no -= 1;

func enemy_count():
	enemy_no -= 1;
	enemy_count_node.text = str(enemy_no);
