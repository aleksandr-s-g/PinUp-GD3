extends Node2D
signal start_button_pressed
signal admob_button_pressed
var selected_mode = ''
# Called when the node enters the scene tree for the first time.
func _ready():
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
	$HUD/Race_btn.rect_size = Vector2(mode_btn_w,mode_btn_h)
	$HUD/Race_btn.rect_position.y = $HUD/Relax_btn.rect_position.y+$HUD/Relax_btn.rect_size.y+20
	$HUD/Race_btn.rect_position.x = $HUD/Relax_btn.rect_position.x
	
	var start_btn_w = get_viewport().get_visible_rect().size.x*0.64
	var start_btn_h = start_btn_w*0.4
	$HUD/Start.get("custom_fonts/font").set_size(font_size)
	$HUD/Start.rect_size = Vector2(start_btn_w,start_btn_h)
	$HUD/Start.rect_position.y = get_viewport().get_visible_rect().size.y - start_btn_h - 20
	$HUD/Start.rect_position.x = get_viewport().get_visible_rect().size.x/2-start_btn_w/2
	
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
