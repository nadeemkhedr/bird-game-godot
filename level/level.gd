extends Node2D

@onready var animal_start = $AnimalStart

var animal_scene = preload("res://animal/animal.tscn")


func _ready():
	SignalManager.on_update_debug_label.connect(on_update_debug_label)
	SignalManager.on_animal_died.connect(on_animal_died)
	on_animal_died()



func on_animal_died():
	var animal = animal_scene.instantiate()
	animal.global_position = animal_start.global_position
	add_child(animal)
		

func on_update_debug_label(text: String):
	$DebugLabel.text = text
