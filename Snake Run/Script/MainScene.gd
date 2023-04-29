extends Node2D

const SNAKE = 0
const APPLE = 1
var apple_pos
var snake_body = [Vector2(6,5)]
var snake_direction = Vector2(1,0)
var apple_eaten = false;

func _ready() -> void:
	apple_pos = place_apple()
	$Music._bg_music()

func place_apple() -> Vector2:
	randomize()
	var x = randi() % 12
	var y = randi() % 12
	return Vector2(x,y)

func draw_apple():
	$SnakeApple.set_cell(apple_pos.x,apple_pos.y,APPLE)

func draw_snake():
#	for block in snake_body:
#	#	$SnakeApple.set_cell(block.x,block.y,SNAKE,false,false,false,Vector2(1,0))
	for block_index in snake_body.size():
		var block = snake_body[block_index]
		
		if block_index == 0:
			var head_direction = head_draw_relation(snake_body[0],snake_body[1])
			if(head_direction == "right"): $SnakeApple.set_cell(block.x,block.y,SNAKE,false,false,false,Vector2(4,0))
			if(head_direction == "left"): $SnakeApple.set_cell(block.x,block.y,SNAKE,false,false,false,Vector2(3,1))
			if(head_direction == "up"): $SnakeApple.set_cell(block.x,block.y,SNAKE,false,false,false,Vector2(3,0))
			if(head_direction == "down"): $SnakeApple.set_cell(block.x,block.y,SNAKE,false,false,false,Vector2(4,1))
			
		elif block_index == snake_body.size() - 1:
			var tail_direction = head_draw_relation(snake_body[-2],snake_body[-1])
			if(tail_direction == "right"): $SnakeApple.set_cell(block.x,block.y,SNAKE,false,false,false,Vector2(4,2))
			if(tail_direction == "left"): $SnakeApple.set_cell(block.x,block.y,SNAKE,false,false,false,Vector2(3,3))
			if(tail_direction == "up"): $SnakeApple.set_cell(block.x,block.y,SNAKE,false,false,false,Vector2(3,2))
			if(tail_direction == "down"): $SnakeApple.set_cell(block.x,block.y,SNAKE,false,false,false,Vector2(4,3))
			
		else:
			var previous_block = snake_body[block_index + 1] - block
			var next_block = snake_body[block_index - 1] - block
			
			if(previous_block.x == next_block.x):
				$SnakeApple.set_cell(block.x,block.y,SNAKE,false,false,false,Vector2(2,1))
			elif(previous_block.y == next_block.y):
				$SnakeApple.set_cell(block.x,block.y,SNAKE,false,false,false,Vector2(1,0))
			
			else:
				if previous_block.y == -1 and next_block.x == 1 or previous_block.x == 1 and next_block.y == -1:
					$SnakeApple.set_cell(block.x,block.y,SNAKE,false,false,false,Vector2(0,1))
				if previous_block.y == 1 and next_block.x == -1 or previous_block.x == -1 and next_block.y == 1:
					$SnakeApple.set_cell(block.x,block.y,SNAKE,false,false,false,Vector2(2,0))
				if previous_block.y == -1 and next_block.x == -1 or previous_block.x == -1 and next_block.y == -1:
					$SnakeApple.set_cell(block.x,block.y,SNAKE,false,false,false,Vector2(2,2))
				if previous_block.y == 1 and next_block.x == 1 or previous_block.x == 1 and next_block.y == 1:
					$SnakeApple.set_cell(block.x,block.y,SNAKE,false,false,false,Vector2(0,0))

func head_draw_relation(first_block:Vector2,second_block:Vector2):
	var block_relation = first_block - second_block
	
	if(block_relation == Vector2(1,0)): return "right"
	if(block_relation == Vector2(-1,0)): return "left"
	if(block_relation == Vector2(0,-1)): return "up"
	if(block_relation == Vector2(0,1)): return "down"

func move_snake():
	if(apple_eaten):
		delete_tiles(SNAKE)
		var body_copy = snake_body.slice(0,snake_body.size() - 1)
		var new_head = body_copy[0] + snake_direction
		body_copy.insert(0,new_head)
		snake_body = body_copy
		apple_eaten = false

	else:
		delete_tiles(SNAKE)
		var body_copy = snake_body.slice(0,snake_body.size() - 2)
		var new_head = body_copy[0] + snake_direction
		body_copy.insert(0,new_head)
		snake_body = body_copy

func delete_tiles(id:int):
	var cells = $SnakeApple.get_used_cells_by_id(id)
	#print("To delete: ",cells)
	for cell in cells:
		$SnakeApple.set_cell(cell.x,cell.y,-1)
		#print("called:",cell.x," ",cell.y)

func _input(event: InputEvent) -> void:
	if(Input.is_action_just_pressed("ui_up")): 
		if not snake_direction == Vector2(0,1):
			snake_direction = Vector2(0,-1)
	if(Input.is_action_just_pressed("ui_down")): 
		if(snake_direction != Vector2(0,-1)):
			snake_direction = Vector2(0,1)
	if(Input.is_action_just_pressed("ui_right")): 
		if not snake_direction == Vector2(-1,0):
			snake_direction = Vector2(1,0)
	if(Input.is_action_just_pressed("ui_left")): 
		if not snake_direction == Vector2(1,0):
			snake_direction = Vector2(-1,0)

func check_apple_eaten():
	if(apple_pos == snake_body[0]):
		apple_pos = place_apple()
		apple_eaten = true
		Global.Score += 1
		$Music._apple_bite()
		
func check_gameover():
	var head = snake_body[0]
	if(head.x > 11 or head.x < 0 or head.y > 11 or head.y < 0):
		reset()
	
	for block in snake_body.slice(1,snake_body.size() - 1):
		if(block == head):
			reset()

func reset():
	#snake_body = [Vector2(6,5)]
	#snake_direction = Vector2(0,0)
	$SnakeApple.visible = false
	#Global.Score = 0
	$RestartButton.visible = true

func _on_SnakeTick_timeout() -> void:
	move_snake()
	draw_apple()
	draw_snake()
	check_apple_eaten()

func _process(delta: float) -> void:
	check_gameover()
	if(apple_pos in snake_body):
		apple_pos = place_apple()


func _on_RestartButton_pressed() -> void:
	get_tree().reload_current_scene()
	snake_body = [Vector2(6,5)]
	snake_direction = Vector2(1,0)
	Global.Score = 0
	$RestartButton.visible = false
