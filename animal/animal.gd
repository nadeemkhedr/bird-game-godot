extends RigidBody2D

var dead = false
var dragging = false
var released = false
var start = Vector2.ZERO
var drag_start = Vector2.ZERO
# Where exactly in the object did we start dragging
var dragged_vector = Vector2.ZERO
var last_dragged_position = Vector2.ZERO
var last_drag_amount = 0.0
var fired_time = 0.0


func _ready():
	start = global_position
	$VisibleOnScreenNotifier2D.screen_exited.connect(on_screen_exited)
	input_event.connect(on_input_event)

func _physics_process(delta):
	update_debug_label()
	
	if released:
		pass
	else:
		if dragging == false:
			return
		else:
			drag_it()
	


func grab_it():
	dragging = true
	drag_start = get_global_mouse_position()
	last_dragged_position = drag_start


func drag_it():
	var gmp = get_global_mouse_position()
	last_drag_amount = (last_dragged_position - gmp).length()
	last_dragged_position = gmp
	
	dragged_vector = gmp - drag_start
	global_position = start + dragged_vector
	
	
func die():
	if dead:
		return
	dead = true
	SignalManager.on_animal_died.emit()
	queue_free()
	


func update_debug_label():
	var s = "g_pos:%s\n" % Utils.vec2_to_str(global_position)
	s += "dragging:%s released:%s\n" % [
		dragging, 
		released
	]
	s += "start:%s drag_start:%s dragged_vector:%s\n" % [
		Utils.vec2_to_str(start),
		Utils.vec2_to_str(drag_start),
		Utils.vec2_to_str(dragged_vector),
	]
	s += "last_dragged_position:%s last_drag_amount:%s\n" % [
		Utils.vec2_to_str(last_dragged_position),
		last_drag_amount,
	]
	s += "ang:%.1f linear:%s fired_time:%.1f\n" % [
		angular_velocity, 
		Utils.vec2_to_str(linear_velocity),
		fired_time
	]
	SignalManager.on_update_debug_label.emit(s)	
	
	
func on_screen_exited():
	die()


func on_input_event(viewport, event: InputEvent, shape_idx):
	# action pressed	
	if dragging || released:
		return	
	
	if event.is_action_pressed("drag"):
		grab_it()
