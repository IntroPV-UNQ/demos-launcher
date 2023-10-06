extends Sprite

export (NodePath) var target_path: NodePath
onready var target: Node2D = get_node(target_path)

export (float) var target_offset: float = 0.0
export (float) var acceleration: float = 10.0
export (float) var max_speed: float = 100.0
export (float) var offset_delta: float = 10.0

export (bool) var character_turns: bool = true

export (NodePath) var animation_path: NodePath
onready var animation_player: AnimationPlayer = get_node(animation_path)

var velocity: float = 0.0


func _physics_process(delta: float) -> void:
	var final_target: Vector2 = target.global_position + Vector2(target_offset, 0.0)
	if abs(global_position.x - final_target.x) < offset_delta:
		velocity = 0.0
		animation_player.play("idle")
	else:
		var direction: float = global_position.direction_to(final_target).x
		velocity = clamp(velocity + acceleration * direction * delta, -max_speed, max_speed)
		flip_h = direction < 0 && character_turns
		animation_player.play("walk")
	position.x += velocity * delta
