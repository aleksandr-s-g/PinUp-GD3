extends Node
# Detects swipe gestures and generates InputEventSwipe events
# that are fed back into the engine.


signal swipe_canceled(start_position)
signal swiped(direction)
signal double_tap


var max_diagonal_slope= 1.5
var scale = 500
var min_swipe_len
var min_swipe_speed
var last_tap_is_drag = false
var last_tap_time = 0
var double_tap_timeout = 0.7

var swipe_start_position: = Vector2()
var first_tap_position: = Vector2()

func get_scale():
	return 1.0

func set_scale(scale):
	min_swipe_len= scale/80
	min_swipe_speed = scale/80
	pass

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		return
	#print(event, last_tap_is_drag)
	
	#if event is InputEventScreenTouch:
	#	if event.pressed:
	#		last_tap_is_drag = false
			
	if event is InputEventScreenDrag:
		#print(event.velocity)
		var abs_direction = event.relative
		var direction: Vector2 = (abs_direction).normalized()
		if abs(direction.x) + abs(direction.y) >= max_diagonal_slope:
			return
		if abs(abs_direction.x) < min_swipe_len and abs(abs_direction.y) < min_swipe_speed:
			return
		var dir
		if abs(abs_direction.x) > abs(abs_direction.y):
			dir = Vector2(-sign(direction.x), 0.0)
		else:
			dir = Vector2(0.0, -sign(direction.y))
		#print (dir)
		emit_signal('swiped', dir)
		last_tap_is_drag = true
	
	if not event is InputEventScreenTouch:
		return
	
	if event.pressed:
		#print ('tap!!!', last_tap_is_drag)
		var this_tap_time = Time.get_unix_time_from_system()
		if this_tap_time - last_tap_time < double_tap_timeout and not last_tap_is_drag:
			emit_signal('double_tap')
			last_tap_time = 0
		else:
			last_tap_time = this_tap_time
		last_tap_is_drag = false
		
	
	return



func _start_detection(position: Vector2) -> void:
	swipe_start_position = position
	#timer.start()


func _end_detection(position: Vector2) -> void:
	#timer.stop()
	var abs_direction = position - swipe_start_position
	var direction: Vector2 = (position - swipe_start_position).normalized()
	
	#print ('swoped lens ',abs(abs_direction.x),' ,', abs(abs_direction.y))
	# Swipe angle is too steep
	if abs(direction.x) + abs(direction.y) >= max_diagonal_slope:
		return
	if abs(abs_direction.x) < min_swipe_len and abs(abs_direction.y) < min_swipe_len:
		return

	var dir
	if abs(direction.x) > abs(direction.y):
		dir = Vector2(-sign(direction.x), 0.0)
	else:
		dir = Vector2(0.0, -sign(direction.y))
	
	emit_signal('swiped', dir)
	#Input.parse_input_event(swipe)


func _on_Timer_timeout() -> void:
	emit_signal('swipe_canceled', swipe_start_position)
