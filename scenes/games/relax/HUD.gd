extends CanvasLayer
signal start_game
signal become_tester
signal back_to_menu

var tester_button_pressed_times = [0,0,0,0,0,0,0,0,0,0]
# Called when the node enters the scene tree for the first time.
func _ready():
	var block_size = get_viewport().get_visible_rect().size.x/10
	var hud_bg_scale_x = get_viewport().get_visible_rect().size.x/$HudBG.get_rect().size.x
	var hud_bg_scale_y = block_size*2/$HudBG.get_rect().size.y
	var coin_img_scale_x = block_size*1.4/$CoinImg.get_rect().size.x
	var coin_img_scale_y = block_size*1.4/$CoinImg.get_rect().size.y
	var font_size = int(block_size * 0.5)
	$HudBG.set_scale(Vector2(hud_bg_scale_x,hud_bg_scale_y))
	$BackButton.rect_size = Vector2(block_size*0.7, block_size*0.7)
	$BackButton.rect_position = Vector2(block_size*0.3, block_size*0.3)
	$ScoreLabel.get_font("font").set_size(font_size)
	$ScoreLabel.rect_position = Vector2(block_size*1.2,block_size*0.4)
	$CoinImg.set_scale(Vector2(coin_img_scale_x,coin_img_scale_y))
	$CoinImg.position = Vector2(get_viewport().get_visible_rect().size.x-block_size*3.3,0)
	$CoinLabel.rect_position = Vector2(get_viewport().get_visible_rect().size.x-block_size*1.5,block_size*0.37)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()
	
func show_scores():
	$ScoreLabel.show()

func update_tester_panel(text):
	$TesterInfo.text = text

func update_score(score):
	$ScoreLabel.text = str(score)
	
func update_coins(coins):
	$CoinLabel.text = str(coins)

func _on_message_timer_timeout():
	$Message.hide()
	pass # Replace with function body.


func _on_start_button_pressed():
	$StartButton.hide()
	emit_signal("start_game")
	pass # Replace with function body.


func _on_tester_button_pressed():
	#print('tester_button_pressed!', Time.get_unix_time_from_system())
	tester_button_pressed_times.append(Time.get_unix_time_from_system())
	tester_button_pressed_times.pop_front()
	var last_clicks_lag = tester_button_pressed_times[9]- tester_button_pressed_times[0]
	if last_clicks_lag < 2.0:
		$TesterInfo.visible = !$TesterInfo.visible
		print('last_clicks_lag')
		tester_button_pressed_times = [0,0,0,0,0,0,0,0,0,0]
		emit_signal("become_tester")
	#print (tester_button_pressed_times)
	#print (last_clicks_lag)
	
	pass # Replace with function body.


func _on_back_button_pressed():
	#$ConfirmationDialog.show()
	emit_signal("back_to_menu")
	pass # Replace with function body.


func _on_confirmation_dialog_confirmed():
	emit_signal("back_to_menu")
	pass # Replace with function body.


func _on_restart_button_pressed():
	pass # Replace with function body.


func _on_relife_button_pressed():
	pass # Replace with function body.
