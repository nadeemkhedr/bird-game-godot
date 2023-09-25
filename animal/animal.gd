extends RigidBody2D

var dead = false

func _physics_process(delta):
	update_debug_label()
	$VisibleOnScreenNotifier2D.screen_exited.connect(on_screen_exited)


func update_debug_label():
	var s = "g_pos:%s\n" % Utils.vec2_to_str(global_position)
	s += "ang:%.1f linear:%s" % [
		angular_velocity, 
		Utils.vec2_to_str(linear_velocity)
	]
	SignalManager.on_update_debug_label.emit(s)	


func die():
	if dead:
		return
	dead = true
	SignalManager.on_animal_died.emit()
	queue_free()
	

func on_screen_exited():
	die()
