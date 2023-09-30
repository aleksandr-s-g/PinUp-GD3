extends Node2D
signal start_button_pressed
signal admob_button_pressed
var selected_mode = ''
var GameSaver = preload("res://scenes/globals/game_saver.tscn")
var gs
# Called when the node enters the scene tree for the first time.
func _ready():
	gs = GameSaver.instance()
	var block_size = get_viewport().get_visible_rect().size.x/10
	var resize_x = get_viewport().get_visible_rect().size.x/$HUD/BackGround.get_rect().size.x
	$HUD/BackGround.set_scale(Vector2(resize_x,resize_x))
	$HUD.set_size(get_viewport().get_visible_rect().size)
	#var btn_texture_size = $HUD/Relax_btn.get_rect().size
	#var btn_scale = get_viewport().get_visible_rect().size.x*0.6/btn_texture_size.x
	#print (btn_text_size)
	#$HUD/Relax_btn.set_scale(Vector2(btn_scale,btn_scale))
	
	#$HUD/Relax_btn.get_rect().size.y = 50
	var mode_btn_w = get_viewport().get_visible_rect().size.x*0.4
	var mode_btn_h = mode_btn_w/2.5
	var font_size = int(mode_btn_h*0.8*0.4)
	$HUD/Relax_btn.get_font("font").set_size(font_size)
	$HUD/Relax_btn.rect_size = Vector2(mode_btn_w,mode_btn_h)
	$HUD/Relax_btn.rect_position.y = get_viewport().get_visible_rect().size.y*0.6
	$HUD/Relax_btn.rect_position.x = get_viewport().get_visible_rect().size.x/2-$HUD/Relax_btn.rect_size.x/2
	#$HUD/GameTypes.get_rect().size.x = 1000
	#$HUD/GameTypes/Relax.get("custom_fonts/font").set_size(int(block_size/2))
	$HUD/Race_btn.get_font("font").set_size(font_size)
	$HUD/Race_btn.rect_size = Vector2(mode_btn_w, mode_btn_h)
	$HUD/Race_btn.rect_position.y = $HUD/Relax_btn.rect_position.y+$HUD/Relax_btn.rect_size.y+20
	$HUD/Race_btn.rect_position.x = $HUD/Relax_btn.rect_position.x
	
	#$HUD/AdMobBtn.get_font("font").set_size(font_size*0.5)
	$HUD/AdMobBtn.rect_size = Vector2(mode_btn_w*1.15,mode_btn_h)
	$HUD/AdMobBtn.rect_position.y = get_viewport().get_visible_rect().size.x*0.05
	$HUD/AdMobBtn.rect_position.x = get_viewport().get_visible_rect().size.x-$HUD/AdMobBtn.rect_size.x - get_viewport().get_visible_rect().size.x*0.03
	
	
	
	var start_btn_w = get_viewport().get_visible_rect().size.x*0.64
	var start_btn_h = start_btn_w*0.4
	$HUD/Start.get("custom_fonts/font").set_size(font_size)
	$HUD/Start.rect_size = Vector2(start_btn_w,start_btn_h)
	$HUD/Start.rect_position.y = get_viewport().get_visible_rect().size.y - start_btn_h - 20
	$HUD/Start.rect_position.x = get_viewport().get_visible_rect().size.x/2-start_btn_w/2
	
	var small_font_size = int(block_size * 0.25)
	var medium_font_size = int(block_size * 0.4)
	var message_bg_scale_x = block_size*8/$HUD/AdMobPopUp/MessageBG.get_rect().size.x
	var message_bg_scale_y = block_size*8/$HUD/AdMobPopUp/MessageBG.get_rect().size.y
	
	var lbls_pos_x = get_viewport().get_visible_rect().size.x/2-block_size*4
	var lbls_pos_up = get_viewport().get_visible_rect().size.y/2-block_size*4
	var message_bg_pos_x = get_viewport().get_visible_rect().size.x/2-block_size*4
	var message_bg_pos_y = get_viewport().get_visible_rect().size.y/2-block_size*4
	
	$HUD/AdMobPopUp/MessageBG.set_scale(Vector2(message_bg_scale_x,message_bg_scale_y))
	print(message_bg_scale_x,message_bg_scale_y)
	$HUD/AdMobPopUp/MessageBG.position = Vector2(message_bg_pos_x,message_bg_pos_y)
	
	$HUD/AdMobPopUp/TYLbl.rect_size.x = block_size*8
	$HUD/AdMobPopUp/GrantedCoinsLbl.rect_size.x = block_size*8
	$HUD/AdMobPopUp/YourBalanceLbl.rect_size.x = block_size*8
	$HUD/AdMobPopUp/BalanceLbl.rect_size.x = block_size*8
	
	$HUD/AdMobPopUp/TYLbl.rect_position = Vector2(lbls_pos_x,lbls_pos_up+block_size*1)
	$HUD/AdMobPopUp/GrantedCoinsLbl.rect_position = Vector2(lbls_pos_x,lbls_pos_up+block_size*1.8)
	$HUD/AdMobPopUp/YourBalanceLbl.rect_position = Vector2(lbls_pos_x,lbls_pos_up+block_size*3.3)
	$HUD/AdMobPopUp/BalanceLbl.rect_position = Vector2(lbls_pos_x,lbls_pos_up+block_size*3.8)
	
	$HUD/AdMobPopUp/TYLbl.get_font("font").set_size(font_size)
	$HUD/AdMobPopUp/GrantedCoinsLbl.get_font("font").set_size(small_font_size)
	$HUD/AdMobPopUp/YourBalanceLbl.get_font("font").set_size(medium_font_size)
	$HUD/AdMobPopUp/BalanceLbl.get_font("font").set_size(medium_font_size)

	var btn_w = block_size*6
	var btn_h = btn_w/5
	
	$HUD/AdMobPopUp/OkBtn.rect_size = Vector2(btn_w, btn_h)
	$HUD/AdMobPopUp/OkBtn.rect_position = Vector2(get_viewport().get_visible_rect().size.x/2-block_size*3, lbls_pos_up+block_size*5.6)
	$HUD/AdMobPopUp/OkBtn.get_font("font").set_size(font_size)
	$HUD/AdMobPopUp.hide()
	
	
	
	_on_Race_btn_pressed()
	
	
	
	
	#print($HUD.get_rect().size)
	#var resize_x = get_viewport().get_visible_rect().size.x/$HUD.get_rect().size.x
	#$HUD.set_scale(Vector2(resize_x,resize_x))
	#pass # Replace with function body.
	#$HUD.custom_minimum_size = get_viewport().get_visible_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#$HUD.size.x = get_viewport().get_visible_rect().size.x
	#$HUD.get_rect().min_size.y = get_viewport().get_visible_rect().size.y
	pass

func select_mode(mode):
	if mode == '':
		return
	if mode == 'race':
		_on_Race_btn_pressed()
	if mode == 'relax':
		_on_Relax_btn_pressed()

func _on_start_button_pressed():
	#print("start_button_pressed")
	emit_signal("start_button_pressed", selected_mode)
	#print('starting ',mode)
	pass # Replace with function body.


func _on_rewarded():
	$HUD/AdMobPopUp.show()
	gs.set_coins(gs.get_coins() + 100)
	$HUD/AdMobPopUp/BalanceLbl.text = str(gs.get_coins())
	$HUD/AdMobPopUp.show()
	


func _on_Relax_btn_pressed():
	selected_mode = 'relax'
	$HUD/Relax_btn.disabled = true
	$HUD/Race_btn.disabled = false
	pass # Replace with function body.


func _on_Race_btn_pressed():
	selected_mode = 'race'
	$HUD/Relax_btn.disabled = false
	$HUD/Race_btn.disabled = true
	pass # Replace with function body.


func _on_AdMobBtn_pressed():
	print('ADMB')
	emit_signal("admob_button_pressed")
	
	pass # Replace with function body.


func _on_OkBtn_pressed():
	$HUD/AdMobPopUp.hide()
	pass # Replace with function body.
