extends HTTPRequest
const uuid_util = preload('res://scenes/globals/analitycs/uuid.gd')
var GameSaver = preload("res://scenes/globals/game_saver.tscn")
var device_info = {}
var cur_user_id = ''
var device_global_ip = '0.0.0.0'
var app_version = '1.2'
var is_tester = false
var coins = 0
var game_saver

func save_user_info():
	var node_data ={
		"user_id" : cur_user_id,
		"is_tester" : is_tester}
	var save_game = File.new()
	save_game.open("user://user_info.save", File.WRITE)
	#var save_game = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	var json_string = JSON.print(node_data)
	save_game.store_line(json_string)

func load_game_info():
	coins = game_saver.get_coins()


func load_user_info():
	
	var fa = File.new()
	if not fa.file_exists("user://user_info.save"):
		cur_user_id = uuid_util.v4()
		save_user_info()
		return # Error! We don't have a save to load.
	

	var save_game = fa.open("user://user_info.save", File.READ)
	var json_string = fa.get_line()
	var parse_result = parse_json(json_string)
	var loaded_ui
	if parse_result:
		loaded_ui = parse_result
	else:
		loaded_ui = {}
		
	if 'user_id' in loaded_ui:
		cur_user_id = loaded_ui['user_id']
	else:
		cur_user_id = uuid_util.v4()
		save_user_info()
		
	if 'is_tester' in loaded_ui:
		is_tester = loaded_ui['is_tester']
		

		
func fill_ip(result, response_code, headers, body):
	var ip = body.get_string_from_utf8()
	device_global_ip = ip
	device_info['global_ip'] = device_global_ip
	#print("Internet IP is: ", ip)
	var event_info = {"ip":ip}
	send_event('ip_recived', event_info)

func get_device_global_ip():
	var http = HTTPRequest.new()
	add_child(http)
	http.connect("request_completed",self, 'fill_ip' )
	http.request("https://api.ipify.org")



func fill_device_info(screen_size):
	load_game_info()
	load_user_info()
	get_device_global_ip()
	device_info = {
		'locale':OS.get_locale(),
		'locale_language':OS.get_locale_language(),
		'model_name': OS.get_model_name(),
		'processor_name':OS.get_processor_name(),
		'os_name' : OS.get_name(),
		'os_version':'hz',
		'device_id':OS.get_unique_id()
	}
	device_info['screen_h']=str(screen_size.y)
	device_info['screen_w']=str(screen_size.x)
	device_info['user_id'] = cur_user_id
	device_info['global_ip'] = device_global_ip
	device_info['is_tester'] = is_tester
	device_info['app_version'] = app_version
	device_info['coins'] = coins


func send_event(event_name, event_details):
	load_game_info()
	device_info['coins'] = coins
	
	event_details['current_scene'] = get_node("/root/Main").current_scene_name
	
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.connect('request_completed', self, '_http_request_completed')
	#http_request.request_completed.connect(self._http_request_completed)
	var cur_fps = Engine.get_frames_per_second()   
	device_info['fps'] = cur_fps
	print (event_name, ' ', event_details)#, ' ', device_info)
	var event_body = {"event_name": event_name,
	"event_details": JSON.print(event_details),
	"device_info":JSON.print(device_info),
	"user_info":cur_user_id}
	var body = JSON.print(event_body)
	#● Error request(url: String, custom_headers: PackedStringArray = PackedStringArray(), method: Method = 0, request_data: String = "")
	var status = http_request.request("https://asgavril.ru/stat/log_event.php", [],true, HTTPClient.METHOD_POST, body)
	if status != OK:
		push_error("An error occurred in the HTTP request.")
	pass

func init_info(screen_size):
	pass

func _ready():
	#print(OS.get_user_data_dir())
	#send_event('alaunch', '{}')
	#print(uuid_util.v4())
	game_saver = GameSaver.instance()
	fill_device_info(get_viewport().get_visible_rect().size)
	
	pass
	# Create an HTTP request node and connect its completion signal.
	
	# Perform a POST request. The URL below returns JSON as of writing.
	# Note: Don't make simultaneous requests using a single HTTPRequest node.
	# The snippet below is provided for reference only.
	
# Called when the HTTP request is completed.
func _http_request_completed(result, response_code, headers, body):
	#print(body.get_string_from_utf8())
	pass
	#var json = JSON.new()
	#json.parse(body.get_string_from_utf8())
	#var response = json.get_data()

	# Will print the user agent string used by the HTTPRequest node (as recognized by httpbin.org).
	#print(response.headers["User-Agent"])


func _on_hud_become_tester():
	if !is_tester:
		is_tester = true
		device_info['is_tester'] = is_tester
		save_user_info() 
		send_event('become_tester', {})

