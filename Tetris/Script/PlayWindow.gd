extends Node2D

onready var tile = $TileMap
onready var wall = $wall
onready var form_line = $FormLine

#J-shape
var j_0 = [Vector2(0,0),Vector2(1,0),Vector2(1,1),Vector2(1,2)];
var j_90 = [Vector2(0,1),Vector2(1,1),Vector2(2,1),Vector2(2,0)];
var j_180 = [Vector2(0,0),Vector2(0,1),Vector2(0,2),Vector2(1,2)];
var j_270 = [Vector2(0,0),Vector2(1,0),Vector2(2,0),Vector2(0,1)];
var j = [j_0,j_90,j_180,j_270];

#I-shape
var i_0 = [Vector2(0,0),Vector2(0,1),Vector2(0,2),Vector2(0,3)];
var i_90 = [Vector2(0,0),Vector2(1,0),Vector2(2,0),Vector2(3,0)];
var i = [i_0,i_90];

#T-shape
var t_0 = [Vector2(0,0),Vector2(0,1),Vector2(0,2),Vector2(1,1)];
var t_90 = [Vector2(0,1),Vector2(1,0),Vector2(1,1),Vector2(1,2)];
var t_180 = [Vector2(0,1),Vector2(1,1),Vector2(2,1),Vector2(1,0)];
var t_270 = [Vector2(0,0),Vector2(1,0),Vector2(2,0),Vector2(1,1)];
var t = [t_0,t_90,t_180,t_270];

#Z-shape
var z_0 = [Vector2(0,0),Vector2(0,1),Vector2(1,1),Vector2(1,2)];
var z_90 = [Vector2(0,1),Vector2(1,1),Vector2(1,0),Vector2(2,0)];
var z = [z_0,z_90];

#O-shape
var o_0 = [Vector2(0,0),Vector2(0,1),Vector2(1,0),Vector2(1,1)];
var o_90 = [Vector2(1,0),Vector2(0,0),Vector2(1,1),Vector2(0,1)];
var o = [o_0,o_90];

#shape array
var shape = [j,i,t,z,o];
var shape_ran = shape.duplicate();

#Movement Variables
var direction = [Vector2.RIGHT, Vector2.LEFT, Vector2.DOWN];
var speed;
var steps : Array; #Right, Left, Down
var req_steps = 10;
var cur_pos = Vector2()
var start_pos = Vector2(5,1);
var prev_pos = Vector2();

#Shape and Atlas Array Variables
var active_shape;
var next_shape;
var prev_active_shape
var shape_atlas;
var next_atlas;
var prev_shape_atlas
var shape_type;
var shape_type_size;
var i_rotation = 0;
var rotation_flag = false;

#left out pieces
var left_pieces = [];
var left_pieces_cur_pos = Vector2(0,0);
var ROW = []
var COL = []

#Timer
var time = 90;

#Score
var score = 0;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	i_rotation = 0;
	steps = [0,0,0]; #Right, Left, Down
	speed = .5;
	active_shape = pick_piece()
	create_piece();
	#is_free(cur_pos);
	$Time.text = String(time);
	$Score.text = String(score);
	$bg.play();

func game():
	i_rotation = 0;
	steps = [0,0,0]; #Right, Left, Down
	speed = .5;
	active_shape = pick_piece()
	create_piece();
	next_piece_show();
	#next_shape = pick_piece();
	#next_atlas = pick_atlas(active);
	#pick_piece()

func next_piece_show():
	var next_shape_board = Vector2(16,4);
	for i in range(14,20):
		for j in range(2,8):
			tile.set_cell(i,j,-1)
	#draw_shape(active_shape, next_shape_board, shape_atlas);
	for i in active_shape:
		tile.set_cell((i.x)+next_shape_board.x,(i.y)+next_shape_board.y,shape_atlas)

func _process(delta: float) -> void:
	input()
	steps[2] += speed;
	for i in range(steps.size()):
		if(steps[i] == req_steps):
			move_piece(direction[i])
			steps[i] = 0;
			if(rotation_flag):
				rotate_piece(direction[i])
				rotation_flag = false;
	if(!is_bottom()):
		prev_active_shape = active_shape;
		prev_shape_atlas = shape_atlas
		prev_pos = cur_pos
		form_line();
		for i in range(1,21):
			check_line();
		#if(!ROW.empty()):
		#	shift_rows()
		#print(ROW);
		if(time != 0):
			game();
		
		if(time == 0):
			game_over();
		

func pick_piece():
	var piece;
	if not shape_ran.empty():
		shape_ran.shuffle();
		piece = shape_ran.pop_front();
		pick_atlas(piece);
	else:
		shape_ran = shape.duplicate();
		shape_ran.shuffle();
		piece = shape_ran.pop_front()
		pick_atlas(piece);
	#print(piece[0])
	shape_type = piece;
	shape_type_size = shape_type.size();
	return piece[0];

func pick_atlas(piece):
	if(piece == shape[0]):
		shape_atlas = 0;
	if(piece == shape[1]):
		shape_atlas = 1;
	if(piece == shape[2]):
		shape_atlas = 2;
	if(piece == shape[3]):
		shape_atlas = 3;
	if(piece == shape[4]):
		shape_atlas = 4;

func create_piece():
	steps = [0,0,0];
	cur_pos = start_pos;
	draw_shape(active_shape,cur_pos,shape_atlas);

func draw_shape(shape,pos,atlas):
	for i in shape:
		tile.set_cell((i.x)+pos.x,(i.y)+pos.y,atlas)

func draw_shape_two(shape,pos,atlas):
	for i in shape:
		form_line.set_cell((i.x)+pos.x,(i.y)+pos.y,atlas)

func erase_piece():
	for i in active_shape:
		tile.set_cell((i+cur_pos).x, (i+cur_pos).y, -1);

func move_piece(dir):
	#print(can_move(dir));
	if(can_move(dir) && is_bottom()):
		erase_piece()
		cur_pos += dir;
		draw_shape(active_shape,cur_pos,shape_atlas)

func input():
	#print(cur_pos);
	var pos_check = Vector2(0,0);
	##if(Input.is_action_just_pressed("ui_left")):
	##	steps[1] += 10;
	#	print("left");
		#pos_check = Vector2(cur_pos.x-1,cur_pos.y);
		#print(can_move());
		#if(!no_movement(pos_check)):
		#	erase_piece()
		#	cur_pos.x += -1;
	#elif(Input.is_action_just_pressed("ui_right")):
	#	steps[0] += 10;
	#	print("right");
	
	#if(Input.is_action_just_pressed("ui_down")):
	#	steps[2] += 10;
	#	print("down");
		
		#pos_check = Vector2(cur_pos.x+1,cur_pos.y);
		#if(!no_movement(pos_check)):
		#	erase_piece()
		#	cur_pos.x += 1;
	if(Input.is_action_just_pressed("ui_left")):
		steps[1] += 10;
	elif(Input.is_action_just_pressed("ui_right")):
		steps[0] += 10;
	elif(Input.is_action_just_pressed("ui_down")):
		steps[2] = speed * 10;
	#	steps[2] += 10;
	elif(Input.is_action_just_pressed("ui_accept")):
		#pos_check = Vector2(cur_pos.x+1,cur_pos.y);
		rotation_flag = true;

func rotate_piece(dir):
	if(can_rotate()):
		erase_piece()
		if(i_rotation == (shape_type_size-1)):
			i_rotation = 0;
			active_shape = shape_type[i_rotation];
		else:
			active_shape = shape_type[i_rotation+1];
			i_rotation += 1;

func no_movement(pos):
	var new_block;
	var flag = false;
	for i in 12:
		for j in 22:
			if((i<1 || i>9) || (j==0 || j==21)):
				new_block = Vector2(i,j);
				#print(new_block);
				if(pos == new_block):
					flag = true;
					#print(pos);
	#print("from func.: ",flag);
	return flag;

func can_move(dir):
	var cm = true;
	#pos_check = Vector2(cur_pos.x-1,Vector2.DOWN);
	for i in active_shape:
		if not is_free(i+cur_pos+dir):
			cm = false
	return cm;

func can_rotate():
	var cr = true;
	var temp_index;
	if(i_rotation == (shape_type_size-1)):
		temp_index = 0;
	else:
		temp_index = i_rotation + 1;
	for i in shape_type[temp_index]:
		if not is_free(i+cur_pos):
			cr = false;
	
	return cr;

func is_free(pos):
	var wall_free = wall.get_cell(pos.x,pos.y) == -1
	var bottom_free = form_line.get_cell(pos.x,pos.y) == -1;
	return (wall_free && bottom_free)

func is_bottom_free(pos):
	return form_line.get_cell(pos.x,pos.y) == -1;

func is_line_free(pos):
	return form_line.get_cell(pos.x,pos.y) == -1;

func is_bottom():
	var ib = true;
	for i in active_shape:
		if not is_free(i+cur_pos+direction[2]):
			ib = false;
	return ib;

func form_line():
	var cell_shape = active_shape;
	var cell_pos = prev_pos;
	for i in cell_shape:
		form_line.set_cell((i.x)+cell_pos.x,(i.y)+cell_pos.y,prev_shape_atlas);
	pass

func check_line():
	var cl = false; #check line
	var lb = false; #line built
	var row; #line row
	var delete_row;
	for i in range(1,21):
		for j in range(1,11):
			if is_line_free(Vector2(j,i)):
				#print("called: ", i)
				cl = false;
				break;
			else:
				cl = true;
			if(j == 10 && cl):
				row = i;
				break;
		if(cl):
			delete_row = i;
			score += 1;
			$line.play();
			#print("Delete Row inside loop:",delete_row);
			ROW.append(i);
			break;

	if(cl):
		#print(ROW);
		lb = true;
		#print(row)
		$Score.text = String(score)
		for col in range(1,11):
			#print("Called Delete Row",delete_row);
			tile.set_cell(col,row,-1);
			form_line.set_cell(col,row,-1);
			#print("Delete Row: ",delete_row);
		shift_rows(delete_row)
		
		#print("=======================================")
		
	return lb;

func move_pieces_down(dir):
	var temp_left_piece = Vector2();
	for i in range(1,21):
		for j in range(1,11):
			temp_left_piece = Vector2(j,i);
			if not is_bottom_free(Vector2(j,i)):
				left_pieces.append(temp_left_piece);
	#for it in 21:
	#	print("called",it);
	#	for i in left_pieces:
	#		tile.set_cell(i.x, i.y, -1);
	#		form_line.set_cell(i.x, i.y, -1);
	#		left_pieces_cur_pos += dir;
	#		draw_shape(left_pieces,left_pieces_cur_pos,shape_atlas);
	#		draw_shape_two(left_pieces,left_pieces_cur_pos,shape_atlas);

func shift_rows(delete_row):
	#print(delete_row);
	var shift_new_pos = Vector2();
	var check_pos = Vector2();
	var next_pos;
	var temp_piece;
	var tileMap_next_pos;
	for s_row in range(delete_row,0,-1):
		#print("called i")
		for s_col in range(1,11):
			#print("called j")
			next_pos = form_line.get_cell(s_col,s_row)
			tileMap_next_pos = tile.get_cell(s_col,s_row);
			#print("(",s_col,",",s_row,")",":",next_pos);
			if next_pos >= 0:
				#print("called");
				temp_piece = Vector2(s_col,s_row+1)
				#print(tileMap_next_pos);
				var shift_atlas = rand_range(0,4);
				form_line.set_cell(temp_piece.x,temp_piece.y,shift_atlas);
				form_line.set_cell(s_col,s_row,-1);
				
				tile.set_cell(temp_piece.x,temp_piece.y,shift_atlas);
				tile.set_cell(s_col,s_row,-1);
			#print(next_pos);
			#for i in range (1,21):
				#check_pos = Vector2(s_col,s_row-i);
				
				#print(check_pos);
				#if not is_bottom_free(check_pos):
				#temp_piece = Vector2(s_col,s_row-i);
				#next_pos = Vector2(temp_piece.x,temp_piece.y+1)
					#print(prev_active_shape);
					#form_line.set_cell(temp_piece.x,temp_piece.y,3);
					#if not is_bottom_free(next_pos):
				#tile.set_cell(temp_piece.x,temp_piece.y,-1);
				#form_line.set_cell(temp_piece.x,temp_piece.y,-1);
					
				#tile.set_cell(temp_piece.x,temp_piece.y+i,3);
				#form_line.set_cell(temp_piece.x,temp_piece.y+i,3);
					
	ROW = [];
	pass

func _on_Timer_timeout() -> void: 
	if (time != 0):
		time -= 1;
	elif (time == 0):
		$Timer.stop();
		
	$Time.text = String(time);

func game_over():
	$GameOver/EndScore.text = String(score);
	$GameOver.visible = true;
