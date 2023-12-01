extends Node2D

export (float) var detection_trigger_mult: float
export (float) var detection_trigget_offset: float

export (NodePath) var character_path: NodePath
onready var character: Node = get_node(character_path)

export (Array, NodePath) var animations_path: Array

var current_i: int = 0


func _physics_process(_delta: float) -> void:
	var i: int = int((global_position.x - detection_trigget_offset) / detection_trigger_mult) % animations_path.size()
	if i != current_i:
		current_i = i
		character.animation_player = get_node(animations_path[current_i])
