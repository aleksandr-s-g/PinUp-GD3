extends Node2D

var loaded_game = {}

func set_coins(new_coins):
	loaded_game['coins'] = new_coins
	save_game()

func set_relax_scores(new_scores):
	loaded_game['relax_scores'] = new_scores
	save_game()

func set_mind_scores(new_scores):
	loaded_game['mind_scores'] = new_scores
	save_game()

func set_race_scores(new_scores):
	loaded_game['race_scores'] = new_scores
	save_game()

func get_coins():
	load_game()
	
	if not 'coins' in loaded_game:
		loaded_game['coins'] = 0
		save_game()
	return loaded_game['coins']

func get_relax_scores():
	load_game()
	if 'relax_scores' in loaded_game:
		pass
	else:
		loaded_game['relax_scores'] = 0
		save_game()
	return loaded_game['relax_scores']
	
	
func get_mind_scores():
	load_game()
	if not 'mind_scores' in loaded_game:
		loaded_game['mind_scores'] = 0
		save_game()
	return loaded_game['mind_scores']

func get_race_scores():
	load_game()
	if not 'race_scores' in loaded_game:
		loaded_game['race_scores'] = 0
		save_game()
	return loaded_game['race_scores']

func save_game():
	var save_game = File.new()
	save_game.open("user://savegame.save", File.WRITE)
	#var save_game = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	var node_data = loaded_game
	var json_string = JSON.print(node_data)

		# Store the save dictionary as a new line in the save file.
	save_game.store_line(json_string)

func load_game():
	var fa = File.new()
	if not fa.file_exists("user://savegame.save"):
		return # Error! We don't have a save to load.
	var save_game = fa.open("user://savegame.save", File.READ)
	var json_string = fa.get_line()
	var parse_result = parse_json(json_string)
	if parse_result:
		loaded_game = parse_result
	else:
		loaded_game = {}
		

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
