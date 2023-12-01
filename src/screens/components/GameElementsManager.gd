extends Node

signal changed_element_focus(element_i, world_focus)

onready var previous_button: TextureButton = $"%PreviousButton"
onready var next_button: TextureButton = $"%NextButton"
onready var play_button: TextureButton = $"%PlayButton"

onready var game_elements: Array = $ElementsContainer.get_children()

var current_i: int = 0


func _ready() -> void:
	$ElementsContainer.show()
	_change_element(0)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("ui_left"):
		_previous_element()
	elif event.is_action_released("ui_right"):
		_next_element()


func _previous_element() -> void:
	if current_i > 0:
		_change_element(current_i - 1)


func _next_element() -> void:
	if current_i < game_elements.size()-1:
		_change_element(current_i + 1)


func _change_element(id: int) -> void:
	current_i = id
	previous_button.visible = current_i > 0
	next_button.visible = current_i < game_elements.size()-1
	play_button.visible = !game_elements[current_i].game_route.empty()
	
	emit_signal("changed_element_focus", current_i, game_elements[current_i].follow_pivot)


func _on_PlayButton_pressed() -> void:
	var route: String = game_elements[current_i].game_route
	if route.empty():
		return
	
	if game_elements[current_i].is_local:
		route = ProjectSettings.globalize_path(route)
		print(route)
		print(OS.execute(
			route,
			["--path", ProjectSettings.globalize_path(game_elements[current_i].game_folder)],
			false,
			[  ],
			true,
			true
		))
	else:
		print(route)
		print(OS.shell_open(route))
