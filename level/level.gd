extends Node2D

func _ready():
	SignalManager.on_update_debug_label.connect(on_update_debug_label)
	

func on_update_debug_label(text: String):
	$DebugLabel.text = text
