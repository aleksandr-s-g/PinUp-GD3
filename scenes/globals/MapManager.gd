extends Node
#@onready var BlueBox = preload("res://scenes/globals/blocks/blue_box.tscn")
#@onready var RedBox = preload("res://scenes/globals/blocks/red_box.tscn")
var BlueBox = preload("res://scenes/globals/blocks/blue_box.tscn")
var RedBox = preload("res://scenes/globals/blocks/red_box.tscn")
var GoldCoin = load("res://scenes/globals/coin.tscn")
var LevelLabel = preload("res://scenes/globals/level_label.tscn")
var cur_lab_loaded_level = 0
var last_filename = ''
var levels_queue = []
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func load_one_local_lab_part(screen_size, dir_with_maps):
	var block_list = []
	var coin_list = []
	var label_list = []
	var map
	if len(levels_queue) == 0:
		levels_queue = dir_contents(dir_with_maps)
		levels_queue.shuffle()
	
	var file = levels_queue.pop_front()
		
	map = read_json_lab_part(dir_with_maps, file)
	label_list.append(create_label(Vector2(cur_lab_loaded_level,0),screen_size, '⬆️'))
	label_list.append(create_label(Vector2(cur_lab_loaded_level+19,0),screen_size, '⬇️'))
	for line_id in range(20):
		var map_line_id = cur_lab_loaded_level+line_id
		#var cur_label = LevelLabel.instantiate()
		block_list.append(create_block(Vector2(map_line_id,-1), 'blue',screen_size))
		block_list.append(create_block(Vector2(map_line_id,10),'red',screen_size))

	for block in map['blocks']:
		block_list.append(create_block(Vector2(block['y']+cur_lab_loaded_level,block['x']), block['colour'],screen_size))
	
	if 'coins' in map:
		for coin in map['coins']:
			coin_list.append(create_coin(Vector2(coin['y']+cur_lab_loaded_level,coin['x']), 'gold',screen_size))
	cur_lab_loaded_level+=20
	return {'coins':coin_list, 'blocks':block_list, 'labels':label_list}
	





func load_next_lab_part(screen_size, dir_with_maps):
	
	var map = read_random_json_lab_part(dir_with_maps)
	var block_list = []
	var coin_list = []
	var label_list = []
	label_list.append(create_label(Vector2(cur_lab_loaded_level,0),screen_size, '⬆️'))
	label_list.append(create_label(Vector2(cur_lab_loaded_level+19,0),screen_size, '⬇️'))
	for line_id in range(20):
		var map_line_id = cur_lab_loaded_level+line_id
		#var cur_label = LevelLabel.instantiate()
		block_list.append(create_block(Vector2(map_line_id,-1), 'blue',screen_size))
		block_list.append(create_block(Vector2(map_line_id,10),'red',screen_size))

		
	for block in map['blocks']:
		block_list.append(create_block(Vector2(block['y']+cur_lab_loaded_level,block['x']), block['colour'],screen_size))
	
	
	for coin in map['coins']:
		coin_list.append(create_coin(Vector2(coin['y']+cur_lab_loaded_level,coin['x']), 'gold',screen_size))
	
	cur_lab_loaded_level+=20
	return {'coins':coin_list, 'blocks':block_list, 'labels':label_list}
	
	
func dir_contents(path):
	var files = []
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()
	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			files.append(file)

	dir.list_dir_end()

	return files
	
	

func read_json_lab_part(dir_path, file_name):
	var lab_part_file = File.new()
	lab_part_file.open(dir_path+file_name, File.READ)
	last_filename = file_name
	var json_string = lab_part_file.get_line()
	var dict = {}
	dict = parse_json(json_string)
	#print('loading ',lab_part_random_file_name)
	return dict
	
func read_random_json_lab_part(dir_with_maps):
	var lab_parts_file_list = dir_contents(dir_with_maps)
	var lab_part_random_file_name = lab_parts_file_list[randi() % lab_parts_file_list.size()]
	return read_json_lab_part(dir_with_maps, lab_part_random_file_name)

func create_block(pos, colour, screen_size):
	var target_bb_size = screen_size.x/10
	var bb
	if colour == 'red':
		bb = RedBox.instance()
	elif colour == 'blue':
		bb = BlueBox.instance()
	else:
		print(colour, ' IS WRONG COLOUR!')
	var bb_size = bb.get_node('Sprite').get_rect().size.x
	var s = target_bb_size/bb_size
	bb.scale = Vector2(s,s)
	var r_mob_size = target_bb_size
	var poz_y = screen_size.y - r_mob_size*(pos.x+1)
	var pos_x = pos.y*target_bb_size
	bb.position = Vector2(pos_x,poz_y)
	return bb

func create_label(pos, screen_size, prefix):
	var target_bb_size = screen_size.x/10
	var cur_label = LevelLabel.instance()
	#print('crating label ', last_filename)
	cur_label.visible = false
	cur_label.get("custom_fonts/font").set_size(int(target_bb_size/2))
	#cur_label.add_theme_font_size_override("font_size", int(target_bb_size/2))
	cur_label.text = prefix+last_filename+prefix
	var poz_y = screen_size.y - target_bb_size*(pos.x+1)+target_bb_size/5
	var pos_x = pos.y*target_bb_size+target_bb_size/5
	cur_label.set_position(Vector2(pos_x,poz_y))
	return cur_label

func create_coin(pos, colour, screen_size):
	var target_bb_size = screen_size.x/10
	var bb
	if colour == 'gold':
		bb = GoldCoin.instance()
	else:
		print(colour, ' IS WRONG COLOUR!')
	var bb_size = bb.get_node('Sprite').get_rect().size.x
	var s = target_bb_size/bb_size
	bb.scale = Vector2(s,s)
	var r_mob_size = target_bb_size
	var poz_y = screen_size.y - r_mob_size*(pos.x+1)
	var pos_x = pos.y*target_bb_size
	bb.position = Vector2(pos_x,poz_y)
	return bb
