extends CanvasLayer
signal start_game
signal become_tester
signal back_to_menu
signal restart
signal relife
var tester_button_pressed_times = [0,0,0,0,0,0,0,0,0,0]
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$RestartButtons/RelifeButton.text = "Relife for 10 coins("+str($RelifeTimer.time_left).pad_decimals(2)+"s)"
	pass
	
func show_message(text):
	$Message.text = text
	$Message.show()
	
func hide_message():
	$Message.hide()
	
func show_scores():
	$Scores/ScoreLabel.show()

func update_tester_panel(text):
	$TesterInfo.text = text

func update_score(score):
	$Scores/ScoreLabel.text = str(score)
	
func update_best_score(score):
	$Scores/BestScoreLabel.text = str('Best: '+str(score))
	
func update_coins(coins):
	$Scores/Coins.text = str(coins)
	

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
	$RestartButtons/RelifeButton.disabled = true
	pass # Replace with function body.


func _on_relife_button_pressed():
	emit_signal('relife')
	pass # Replace with function body.
