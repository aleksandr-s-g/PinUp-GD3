extends Node2D
var MainMenu = preload("res://scenes/globals/main_menu.tscn")
var GameRelax = preload("res://scenes/games/relax/game_relax.tscn")
var GameMind = preload("res://scenes/games/mind/game_mind.tscn")
var GameRace = preload("res://scenes/games/race/game_race.tscn")
var GameSaver = preload("res://scenes/globals/game_saver.tscn")
var Admob = preload("res://addons/admob/test/Example.tscn")
var main_menu
var game_relax
var game_mind
var game_race
var admob_scene
var current_scene_name
var gs
var last_started_mode = ''
# Called when the node enters the scene tree for the first time.
#b.connect('collected',self,'_on_collect_coin')
func init_main_menu():
	main_menu = MainMenu.instance()
	main_menu.select_mode(last_started_mode)
	main_menu.connect("start_button_pressed",self, '_on_main_menu_start_button_pressed')
	main_menu.connect("admob_button_pressed",self, '_on_main_menu_admob_button_pressed')
	$AdController.connect("rewarded_sig",main_menu, '_on_rewarded')
	
	
func init_game_relax():
	last_started_mode = 'relax'
	game_relax = GameRelax.instance()
	game_relax.connect("back_to_menu",self, '_on_game_back_to_menu')
	game_relax.connect("send_event", $Analitycs, 'send_event')
	game_relax.connect("send_fb_event", $Analitycs, 'send_fb_event')
	$HUD.connect("set_tester_info_visibility", game_relax,'_on_hud_set_tester_info_visibility')
	game_relax.connect("try_show_interstitial",$AdController,"_on_try_show_interstitial")
	game_relax.set_tester_visibility($HUD/TesterInfo.visible)
	
func init_admob_scene():
	admob_scene = Admob.instance()
	admob_scene.rect_min_size = get_viewport().get_visible_rect().size
	#print(admob_scene.get_rect().size)
	
func init_game_race():
	last_started_mode = 'race'
	game_race = GameRace.instance()
	game_race.connect("back_to_menu",self, '_on_game_back_to_menu')
	game_race.connect("send_event", $Analitycs, 'send_event')
	game_race.connect('restart_race',self,  '_on_race_restart')
	game_race.connect("send_fb_event", $Analitycs, 'send_fb_event')
	game_race.connect("try_show_interstitial",$AdController,"_on_try_show_interstitial")
	$HUD.connect("set_tester_info_visibility", game_race,'_on_hud_set_tester_info_visibility')
	game_race.set_tester_visibility($HUD/TesterInfo.visible)
	
func init_game_mind():
	game_mind = GameMind.instance()
	game_mind.connect("back_to_menu",self, '_on_game_back_to_menu')
	game_mind.connect("send_event", $Analitycs, 'send_event')
	game_mind.connect("send_fb_event", $Analitycs, 'send_fb_event')
	$HUD.connect("set_tester_info_visibility", game_mind,'_on_hud_set_tester_info_visibility')
	game_mind.set_tester_visibility($HUD/TesterInfo.visible)
	
func select_scene(new_scene):
	#print(new_scene.name)
	var event_details = {"new_scene_name" : new_scene.name}
	$Analitycs.send_event("scene_changed", event_details)
	for obj in get_children():
		if obj.is_in_group("scenes"):
			remove_child(obj)
			obj.remove_from_group("scenes")
			obj.queue_free()
	add_child(new_scene)
	current_scene_name = new_scene.name
	new_scene.add_to_group("scenes")

func _ready():
	gs = GameSaver.instance()
	#var resize_x = get_viewport().get_visible_rect().size.x/$HUD/BackGround.get_rect().size.x
	#$HUD/BackGround.set_scale(Vector2(resize_x,resize_x))
	$Analitycs.send_event('launch', {})
	$Analitycs.send_fb_event('launch', {})
	init_main_menu()
	select_scene(main_menu)
	$HUD.connect("send_event", $Analitycs,'send_event')
	$HUD.connect("send_fb_event", $Analitycs,'send_fb_event')
	$HUD.connect("become_tester", $Analitycs,'_on_hud_become_tester')
	$AdController.connect("send_event", $Analitycs, 'send_event')
	$HUD/TesterInfo.hide()
	print("$AdMob.load_rewarded_video()")
	#$HUD/BackGround.hide()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_main_menu_admob_button_pressed():
	print('Changing scene to admob...')
	$AdController.show_rewarded()
	#init_admob_scene()
	#select_scene(admob_scene)
	pass

func _on_main_menu_start_button_pressed(mode):
	if mode == 'relax':
		init_game_relax()
		select_scene(game_relax)
	if mode == 'mind':
		init_game_mind()
		select_scene(game_mind)
	if mode == 'race':
		init_game_race()
		select_scene(game_race)
	#init_game_relax()
	#select_scene(game_relax)

	pass # Replace with function body.
	
func _on_race_restart():
		init_game_race()
		select_scene(game_race)
		
		
func _on_game_back_to_menu():
	init_main_menu()
	select_scene(main_menu)






func _on_AddCoinsBtn_pressed():
	gs.set_coins(gs.get_coins() + 1000)
	pass # Replace with function body.
