extends Node2D

#const grid variables
export (int) var height;
export (int) var width;
export (int) var x_start;
export (int) var y_start;
export (int) var offset;
var y_offset = 2;

#state machine
enum {WAIT,MOVE};
var state;

#array to store the pieces
var all_pieces = []

#array to take the possible pieces that the board can have
var possible_pieces = [
	preload("res://Piece/Piece_blue.tscn"),
	preload("res://Piece/Piece_green.tscn"),
	preload("res://Piece/Piece_red.tscn"),
	preload("res://Piece/Piece_yellow.tscn")
]

#touch variables
var touch_first = Vector2(0,0)
var touch_final = Vector2(0,0)
var controlling = false;

#swap back variables
var first_piece = null;
var second_piece = null;
var last_place = Vector2(0,0);
var lastSwap_direction = Vector2(0,0)
var move_checked;

#score variables
signal update_score;
var piece_points = 10;
var streak = 1;

#move_count variables
signal update_move;
export (int) var total_move_count;

#timer variables
signal timer_status_signal;
var timer_status = true
var time_count

#game_over variables
signal game_over_details;

#visual_effect variable
var particle_effect = preload("res://Scene/ParticleSystem.tscn");

func _ready() -> void:
	Music.bg_music();
	state = MOVE
	randomize()
	all_pieces = make_2d_array()
	piece_spawn()
	get_parent().get_node("EndScene").move_initial(total_move_count)
	emit_signal('update_move',total_move_count);
	time_count = get_parent().get_node("Top_ui").game_timer;
	
	#emit_signal("timer_status_signal",timer_status)
	#_on_GameTimer_timeout();

func _process(delta: float) -> void:
	game_pause();
	if state == MOVE:
		touch_input()
	GameTimer_timeout();

#function to make a 2-D array board
func make_2d_array():
	var array = []
	for i in width:
		array.append([])
		for j in height:
			array[i].append(null)
	
	return array;

#function to spawn pieces
func piece_spawn():
	for i in width:
		for j in height:
			#choose random number for array of pieces
			var rand = floor(rand_range(0,possible_pieces.size()))
			#make instance and assign it to piece
			var piece = possible_pieces[rand].instance()
			var loop = 0;
			#check if the corresponding pieces are matching, then run the rand again and assign a new value to spawn from the possible list of pieces
			#loop will run only 100 times
			while(match_pieces(i,j,piece.piece_color) && loop < 100):
				rand = floor(rand_range(0,possible_pieces.size()))
				piece = possible_pieces[rand].instance()
				loop += 1
			
			#add_child is used to make a corresponding node/element in the current node
			add_child(piece)
			piece.position = grid_to_pixel(i,j)
			#assign the pice insidethe master array, which contains the board
			all_pieces[i][j] = piece

#function to check if the corresponding pieces have color match
func match_pieces(i,j, color):
	#check if the column matches
	#check if the column is not the left-most element
	if i > 1:
		#check if the corresponding elements are not null
		if all_pieces[i-1][j] != null && all_pieces[i-2][j] != null:
			#check if the color matches, then return true
			if all_pieces[i-1][j].piece_color == color && all_pieces[i-2][j].piece_color == color:
				return true
	#check if the row matches
	#check if the column is not the left-most element
	if j > 1:
		#check if the corresponding elements are not null
		if all_pieces[i][j-1] != null && all_pieces[i][j-2] != null:
			#check if the color matches, then return true
			if all_pieces[i][j-1].piece_color == color && all_pieces[i][j-2].piece_color == color:
				return true

#function to simulate screen touch
func touch_input():
	var grid_pos1
	var grid_pos2
	#check the press touch
	if Input.is_action_just_pressed("touch_ui"):
		touch_first = get_global_mouse_position()
		grid_pos1 = pixel_to_grid(touch_first.x, touch_first.y)
		if is_in_grid(grid_pos1.x,grid_pos1.y):
			controlling = true;
	
	if Input.is_action_just_released("touch_ui"):
		touch_final = get_global_mouse_position()
		grid_pos2 = pixel_to_grid(touch_final.x, touch_final.y)
		if is_in_grid(grid_pos2.x,grid_pos2.y) && controlling:
			move_direction(pixel_to_grid(touch_first.x, touch_first.y), pixel_to_grid(touch_final.x, touch_final.y))
			controlling = false

#check if the actions are happening inside the grid structure
func is_in_grid(col,row):
	if(col >= 0 && col < width):
		if(row >= 0 && row < height):
			return true
	return false

#check the direction of the swap
func move_direction(grid1, grid2):
	var diff = grid2 - grid1
	if abs(diff.x) > abs(diff.y):
		if diff.x > 0:
			swap_pieces(grid1.x, grid1.y, Vector2(1,0))
		elif diff.x < 0:
			swap_pieces(grid1.x, grid1.y, Vector2(-1,0))
	
	if abs(diff.y) > abs(diff.x):
		if diff.y > 0:
			swap_pieces(grid1.x, grid1.y, Vector2(0,1))
		elif diff.y < 0:
			swap_pieces(grid1.x, grid1.y, Vector2(0,-1))

#swap the pieces
func swap_pieces(col, row, direction):
	var first_piece = all_pieces[col][row]
	var second_piece = all_pieces[col + direction.x][row + direction.y]
	if(first_piece != null && second_piece != null):
		swap_info(first_piece,second_piece,Vector2(col,row),direction);
		state = WAIT;
		all_pieces[col][row] = second_piece
		all_pieces[col + direction.x][row + direction.y] = first_piece
		first_piece.move(grid_to_pixel(col + direction.x, row + direction.y))
		second_piece.move(grid_to_pixel(col,row))
		if(!move_checked):
			matched()

#function to store info of swap
func swap_info(piece_one,piece_two,place,direction):
	first_piece = piece_one;
	second_piece = piece_two;
	last_place = place;
	lastSwap_direction = direction;

#function to swap back pieces, if no match
func swap_back():
	if first_piece != null && second_piece != null:
		swap_pieces(last_place.x, last_place.y, lastSwap_direction)
	move_checked = false;
	state = MOVE

#function to convert the grid number to pixels
func grid_to_pixel(row,col):
	var pix_x = x_start + (offset * row)
	var pix_y = y_start + (-offset * col)
	return Vector2(pix_x,pix_y)

#function to convert the pixels to grid number
func pixel_to_grid(x_pixel,y_pixel):
	var new_x = round((x_pixel - x_start) / offset)
	var new_y = round((y_pixel - y_start) / -offset)
	return Vector2(new_x,new_y)

#function is used to check if pieces are matched after swap
func matched():
	for i in width:
		for j in height:
			if(all_pieces[i][i] != null):
				var current_color =  all_pieces[i][j].piece_color;
				#check horizontal pieces
				if(i > 0 && i < (width - 1)):
					if(all_pieces[i-1][j] != null && all_pieces[i+1][j] != null):
						if(all_pieces[i-1][j].piece_color == current_color && all_pieces[i+1][j].piece_color ==  current_color):
							all_pieces[i][j].matched = true;
							all_pieces[i][j].dim();
							all_pieces[i-1][j].matched = true;
							all_pieces[i-1][j].dim();
							all_pieces[i+1][j].matched = true;
							all_pieces[i+1][j].dim();
				#check for vertical pieces
				if(j > 0 && j < (height - 1)):
					if(all_pieces[i][j-1] != null && all_pieces[i][j+1] != null):
						if(all_pieces[i][j-1].piece_color == current_color && all_pieces[i][j+1].piece_color ==  current_color):
							all_pieces[i][j].matched = true;
							all_pieces[i][j].dim();
							all_pieces[i][j-1].matched = true;
							all_pieces[i][j-1].dim();
							all_pieces[i][j+1].matched = true;
							all_pieces[i][j+1].dim();
	get_parent().get_node("destroy_timer").start();

#function to destroy the matched pieces
func destroy_matched():
	var was_matched = false;
	for i in width:
		for j in height:
			if(all_pieces[i][j] != null):
				if(all_pieces[i][j].matched):
					was_matched = true;
					all_pieces[i][j].queue_free();
					all_pieces[i][j] = null;
					particle_effect(particle_effect,i,j);
					emit_signal('update_score', (piece_points * streak));
	move_checked = true;
	if was_matched == true:
		get_parent().get_node("collapse_timer").start();
	else:
		swap_back()

#function to collapse the matched pieces.
func collapse_column():
	for i in width:
		for j in height:
			if all_pieces[i][j] == null:
				for k in range(j+1, height):
					if(all_pieces[i][k] != null):
						all_pieces[i][k].move(grid_to_pixel(i,j));
						all_pieces[i][j] = all_pieces[i][k];
						all_pieces[i][k] = null;
						break
	get_parent().get_node("refill_timer").start();

#function to refill the detroyed pieces locations
func refill_column():
	streak += 1;
	for i in width:
		for j in height:
			if(all_pieces[i][j] == null):
				#choose random number for array of pieces
				var rand = floor(rand_range(0,possible_pieces.size()))
				#make instance and assign it to piece
				var piece = possible_pieces[rand].instance()
				var loop = 0;
				#check if the corresponding pieces are matching, then run the rand again and assign a new value to spawn from the possible list of pieces
				#loop will run only 100 times
				while(match_pieces(i,j,piece.piece_color) && loop < 100):
					rand = floor(rand_range(0,possible_pieces.size()))
					piece = possible_pieces[rand].instance()
					loop += 1
				
				#add_child is used to make a corresponding node/element in the current node
				add_child(piece)
				piece.position = grid_to_pixel(i,j + y_offset);
				piece.move(grid_to_pixel(i,j))
				#assign the pice insidethe master array, which contains the board
				all_pieces[i][j] = piece;
	after_refill()

#function called for actions after refill
func  after_refill():
	for i in width:
		for j in height:
			if all_pieces[i][j] != null:
				if match_pieces(i,j,all_pieces[i][j].piece_color):
					matched()
					return
	move_checked = false;
	state = MOVE
	streak = 1;
	total_move_count -= 1;
	emit_signal('update_move');
	if(total_move_count == 0):
		game_over();

#timer which runs to check destroy function
func _on_destroy_timer_timeout() -> void:
	destroy_matched();

#timer which runs to check collapse function
func _on_collapse_timer_timeout() -> void:
	collapse_column()

#timer which runs to check refill function
func _on_refill_timer_timeout() -> void:
	refill_column();

#function for particle effect of the detroyed pieces
func particle_effect(effect,row,col):
	var current = effect.instance();
	current.position = grid_to_pixel(row,col);
	add_child(current);

func game_pause():
	if(Input.is_action_pressed("ui_cancel")):
		Music.click_sound();
		state = WAIT
		get_parent().get_node("MenuSlide").play("pause_menu");
		get_parent().get_node("DullAnimation").play("dull_bg");

func resume_play():
	get_parent().get_node("MenuSlide").play_backwards("pause_menu");
	get_parent().get_node("DullAnimation").play_backwards("dull_bg");
	state = MOVE

func game_over():
	Music.stop_music();
	state = WAIT;
	emit_signal("game_over_details");
	get_parent().get_node("MenuSlide").play("end_scene");
	get_parent().get_node("DullAnimation").play("dull_bg");
	#get_parent().get_node("EndScene").score_details(current_score);
	#get_parent().get_node("EndScene").move_used(current_move_count);

func GameTimer_timeout() -> void:
	if(state == WAIT):
		timer_status = false;
	else:
		timer_status = true;
	emit_signal("timer_status_signal",timer_status)
