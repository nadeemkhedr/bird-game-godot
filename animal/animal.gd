extends RigidBody2D

func _physics_process(delta):
	update_debug_label()


func update_debug_label():
	var s = "g_pos:%s\n" % Utils.vec2_to_str(global_position)
	s += "ang:%.1f linear:%s" % [
		angular_velocity, 
		Utils.vec2_to_str(linear_velocity)
	]
	SignalManager.on_update_debug_label.emit(s)	
