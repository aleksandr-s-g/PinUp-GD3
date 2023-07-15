extends CanvasLayer
signal start_game
signal become_tester
signal back_to_menu
signal restart
signal relife
var tester_button_pressed_times = [0,0,0,0,0,0,0,0,0,0]
# Called when the node enters the scene tree for the first time.
func _ready():
	var block_size = get_viewport().get_visible_rect().size.x/10
	var hud_bg_scale_x = get_viewport().get_visible_rect().size.x/$HudBG.get_rect().size.x
	var hud_bg_scale_y = block_size*2/$HudBG.get_rect().size.y
	var coin_img_scale_x = block_size*1.4/$CoinImg.get_rect().size.x
	var coin_img_scale_y = block_size*1.4/$CoinImg.get_rect().size.y
	var message_bg_scale_x = block_size*8/$GoingToLose/MessageBG.get_rect().size.x
	var message_bg_scale_y = block_size*8/$GoingToLose/MessageBG.get_rect().size.y
	var font_size = int(block_size * 0.5)
	var small_font_size = int(block_size * 0.25)
	var medium_font_size = int(block_size * 0.4)
	$HudBG.set_scale(Vector2(hud_bg_scale_x,hud_bg_scale_y))
	$HudBG.position = Vector2(0,0)
	$BackButton.rect_size = Vector2(block_size*0.7, block_size*0.7)
	$BackButton.rect_position = Vector2(block_size*0.3, block_size*0.3)
	$ScoreLabel.get_font("font").set_size(font_size)
	$ScoreLabel.rect_position = Vector2(block_size*1.4,block_size*0.4)
	$CoinImg.set_scale(Vector2(coin_img_scale_x,coin_img_scale_y))
	$CoinImg.position = Vector2(get_viewport().get_visible_rect().size.x-block_size*3.3,0)
	$CoinLabel.rect_position = Vector2(get_viewport().get_visible_rect().size.x-block_size*2,block_size*0.37)
	$BestScoreLabel.get_font("font").set_size(small_font_size)
	$BestScoreLabel.rect_position = Vector2(block_size*1.4,block_size*1.1)
	
	$GoingToLose/MessageBG.set_scale(Vector2(message_bg_scale_x,message_bg_scale_y))
	$LosePopUp/MessageBG.set_scale(Vector2(message_bg_scale_x,message_bg_scale_y))
	var message_bg_pos_x = get_viewport().get_visible_rect().size.x/2-block_size*4
	var message_bg_pos_y = get_viewport().get_visible_rect().size.y/2-block_size*4
	$GoingToLose/MessageBG.position = Vector2(message_bg_pos_x,message_bg_pos_y)
	$LosePopUp/MessageBG.position = Vector2(message_bg_pos_x,message_bg_pos_y)
	$GoingToLose/LoseAfterLbl.get_font("font").set_size(font_size)
	var lose_after_pos_y = get_viewport().get_visible_rect().size.y/2-block_size*4+block_size
	var lose_after_pos_x = get_viewport().get_visible_rect().size.x/2-block_size*4
	$GoingToLose/LoseAfterLbl.rect_position = Vector2(lose_after_pos_x,lose_after_pos_y)
	$GoingToLose/LoseAfterLbl.rect_size.x = block_size*8
	
	$GoingToLose/ToContinueLbl.get_font("font").set_size(medium_font_size)
	var to_continue_pos_y = get_viewport().get_visible_rect().size.y/2-block_size*4+block_size*2.9
	var to_continue_pos_x = get_viewport().get_visible_rect().size.x/2-block_size*4
	$GoingToLose/ToContinueLbl.rect_position = Vector2(0,0)
	$GoingToLose/ToContinueLbl.rect_position.y = to_continue_pos_y
	$GoingToLose/ToContinueLbl.rect_position.x = to_continue_pos_x
	#$GoingToLose/ToContinueLbl.rect_position = Vector2(to_continue_pos_y,to_continue_pos_x)
	$GoingToLose/ToContinueLbl.rect_size.x = block_size*8
	

	var double_tap_img_scale_x = block_size*1.2/$GoingToLose/DoubleTapImg.get_rect().size.x
	var double_tap_img_scale_y = block_size*1.2/$GoingToLose/DoubleTapImg.get_rect().size.y
	$GoingToLose/DoubleTapImg.set_scale(Vector2(double_tap_img_scale_x,double_tap_img_scale_y))
	var double_tap_img_pos_y = get_viewport().get_visible_rect().size.y/2-block_size*4+block_size*4.5
	var double_tap_img_pos_x = get_viewport().get_visible_rect().size.x/2 - $GoingToLose/DoubleTapImg.get_rect().size.x/2
	$GoingToLose/DoubleTapImg.position = Vector2(double_tap_img_pos_x,double_tap_img_pos_y)
	
	$GoingToLose/DoubleTapCostLbl.get_font("font").set_size(medium_font_size)
	var double_tab_cost_pos_y = get_viewport().get_visible_rect().size.y/2-block_size*4+block_size*5.9
	var double_tab_cost_pos_x = get_viewport().get_visible_rect().size.x/2-block_size*4
	$GoingToLose/DoubleTapCostLbl.rect_position = Vector2(0,0)
	$GoingToLose/DoubleTapCostLbl.rect_position.y = double_tab_cost_pos_y
	$GoingToLose/DoubleTapCostLbl.rect_position.x = double_tab_cost_pos_x
	#$GoingToLose/ToContinueLbl.rect_position = Vector2(to_continue_pos_y,to_continue_pos_x)
	$GoingToLose/DoubleTapCostLbl.rect_size.x = block_size*8
	
	var lbls_pos_x = get_viewport().get_visible_rect().size.x/2-block_size*4
	var lbls_pos_up = get_viewport().get_visible_rect().size.y/2-block_size*4
	$LosePopUp/YouLoseLbl.rect_size.x = block_size*8
	$LosePopUp/LoseScoresLbl.rect_size.x = block_size*8
	$LosePopUp/TimeToRelifeLbl.rect_size.x = block_size*8
	$LosePopUp/TimeLeftLbl.rect_size.x = block_size*8
	
	$LosePopUp/YouLoseLbl.rect_position = Vector2(lbls_pos_x,lbls_pos_up+block_size*1)
	$LosePopUp/LoseScoresLbl.rect_position = Vector2(lbls_pos_x,lbls_pos_up+block_size*1.8)
	$LosePopUp/TimeToRelifeLbl.rect_position = Vector2(lbls_pos_x,lbls_pos_up+block_size*2.5)
	$LosePopUp/TimeLeftLbl.rect_position = Vector2(lbls_pos_x,lbls_pos_up+block_size*3)
	
	$LosePopUp/YouLoseLbl.get_font("font").set_size(font_size)
	$LosePopUp/LoseScoresLbl.get_font("font").set_size(small_font_size)
	$LosePopUp/TimeToRelifeLbl.get_font("font").set_size(medium_font_size)
	$LosePopUp/TimeLeftLbl.get_font("font").set_size(medium_font_size)

	var btn_w = block_size*6
	var btn_h = btn_w/5
	$LosePopUp/RelifeBtn.rect_size = Vector2(btn_w, btn_h)
	$LosePopUp/RelifeBtn.rect_position = Vector2(get_viewport().get_visible_rect().size.x/2-block_size*3, lbls_pos_up+block_size*4)
	$LosePopUp/RelifeBtn.get_font("font").set_size(font_size)
	
	$LosePopUp/RestartBtn.rect_size = Vector2(btn_w, btn_h)
	$LosePopUp/RestartBtn.rect_position = Vector2(get_viewport().get_visible_rect().size.x/2-block_size*3, lbls_pos_up+block_size*5.6)
	$LosePopUp/RestartBtn.get_font("font").set_size(font_size)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$LosePopUp/TimeLeftLbl.text = str($RelifeTimer.time_left).pad_decimals(2)
	pass
	
func set_lose_after(time_left):
	$GoingToLose/LoseAfterLbl.text = 'You lose after \n'+str(time_left).pad_decimals(2)

	
func show_scores():
	$Scores/ScoreLabel.show()

func update_tester_panel(text):
	$TesterInfo.text = text

func update_score(score):
	$LosePopUp/LoseScoresLbl.text = 'Scores: '+str(score)
	$ScoreLabel.text = str(score)
	
func update_best_score(score):
	$BestScoreLabel.text = str('best: '+str(score))
	
func update_coins(coins):
	$CoinLabel.text = str(coins)
	

func _on_message_timer_timeout():
	#$Message.hide()
	#emit_signal("back_to_menu")
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
	emit_signal('restart')
	pass # Replace with function body.


func _on_relife_timer_timeout():
	$LosePopUp/RelifeBtn.disabled = true
	pass # Replace with function body.


func _on_relife_button_pressed():
	emit_signal('relife')
	pass # Replace with function body.
