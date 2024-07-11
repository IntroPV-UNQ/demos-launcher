extends Screen

onready var level_container: Node = $LevelContainer
onready var years_buttons: Array = $"%YearsContainer".get_children()

export (Array, PackedScene) var levels: Array

var current_i: int = 0


func _ready() -> void:
	for i in years_buttons.size():
		var button: Button = years_buttons[i]
		button.connect("pressed", self, "_on_year_button_pressed", [i])
	
	_on_year_button_pressed(levels.size() - 1)


func _on_year_button_pressed(index: int) -> void:
	if index == current_i:
		return
	
	for i in years_buttons.size():
		var button: Button = years_buttons[i]
		button.pressed = i == index
	
	_change_current_level(index)


func _change_current_level(i: int) -> void:
	years_buttons[current_i].pressed = false
	current_i = i
	years_buttons[current_i].pressed = true
	if level_container.get_child_count() > 0:
		for child in level_container.get_children():
			level_container.remove_child(child)
			child.queue_free()
	
	var level: Node = levels[i].instance()
	level_container.add_child(level)


func _on_ExitButton_pressed() -> void:
	get_tree().quit()
