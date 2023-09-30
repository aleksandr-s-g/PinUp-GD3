extends Node
signal rewarded_sig
signal send_event
var last_interstitial_show_time
var time_from_last_interstitial_show
var last_rewarded_requested_time
var last_interstitial_requested_time
var interstitial_time_limit = 60*5
var rewarded_request_time_limit = 10
var interstitial_request_time_limit = 10
var is_rewarded_loaded
var is_interstitial_loaded
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	last_interstitial_show_time = Time.get_unix_time_from_system()
	time_from_last_interstitial_show = 0
	last_rewarded_requested_time = 0
	is_rewarded_loaded = false
	last_interstitial_requested_time = 0
	is_interstitial_loaded = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time_from_last_interstitial_show+=delta
	handle_rewarded_loading()
	handle_interstitial_loading()
	#print (Time.get_unix_time_from_system(),' - ',time_from_last_interstitial_show)
#	pass


func _on_try_show_interstitial():
	if time_from_last_interstitial_show < interstitial_time_limit:
		return
	time_from_last_interstitial_show = 0
	$AdMob.show_interstitial()
	is_interstitial_loaded = false
	var event_info = {"is_interstitial_loaded":is_interstitial_loaded}
	emit_signal('send_event','admob-show_interstitial', event_info)
	
	
func handle_rewarded_loading():
	if is_rewarded_loaded:
		return
	var now = Time.get_unix_time_from_system()
	if now - last_rewarded_requested_time > rewarded_request_time_limit:
		$AdMob.load_rewarded_video()
		last_rewarded_requested_time = now
		emit_signal('send_event','admob-try_load_rewarded_video', {})
		
func handle_interstitial_loading():
	if is_interstitial_loaded:
		return
	var now = Time.get_unix_time_from_system()
	if now - last_interstitial_requested_time > interstitial_request_time_limit:
		$AdMob.load_interstitial()
		last_interstitial_requested_time = now
		emit_signal('send_event','admob-try_load_interstitial', {})
		
		
func show_rewarded():
	var event_info = {"is_rewarded_loaded":is_rewarded_loaded}
	emit_signal('send_event','admob-show_rewarded', event_info)
	$AdMob.show_rewarded_video()
	is_rewarded_loaded = false


func _on_AdMob_rewarded(currency, amount):
	var event_info = {"currency":currency, "amount":amount}
	emit_signal('send_event','admob-rewarded',event_info)
	emit_signal("rewarded_sig")
	pass # Replace with function body.


func _on_AdMob_rewarded_clicked():
	emit_signal('send_event','admob-rewarded_clicked', {})
	pass # Replace with function body.


func _on_AdMob_rewarded_impression():
	emit_signal('send_event','admob-rewarded_impression', {})
	pass # Replace with function body.


func _on_AdMob_rewarded_video_closed():
	emit_signal('send_event','admob-rewarded_video_closed', {})
	pass # Replace with function body.


func _on_AdMob_rewarded_video_opened():
	emit_signal('send_event','admob-rewarded_video_opened', {})
	pass # Replace with function body.


func _on_AdMob_rewarded_video_failed_to_load(error_code):
	var event_info = {"error_code":error_code}
	emit_signal('send_event','admob-rewarded_video_failed_to_load',event_info)
	pass # Replace with function body.


func _on_AdMob_rewarded_video_loaded():
	is_rewarded_loaded = true
	emit_signal('send_event','admob-rewarded_video_loaded', {})
	pass # Replace with function body.


func _on_AdMob_interstitial_clicked():
	emit_signal('send_event','admob-interstitial_clicked', {})
	pass # Replace with function body.


func _on_AdMob_interstitial_closed():
	emit_signal('send_event','admob-interstitial_closed', {})
	pass # Replace with function body.


func _on_AdMob_interstitial_failed_to_load(error_code):
	var event_info = {"error_code":error_code}
	emit_signal('send_event','admob-interstitial_failed_to_load',event_info)
	pass # Replace with function body.


func _on_AdMob_interstitial_impression():
	emit_signal('send_event','admob-interstitial_impression', {})
	pass # Replace with function body.


func _on_AdMob_interstitial_loaded():
	emit_signal('send_event','admob-interstitial_loaded', {})
	is_interstitial_loaded = true
	pass # Replace with function body.


func _on_AdMob_interstitial_opened():
	emit_signal('send_event','admob-interstitial_opened', {})
	pass # Replace with function body.
