extends Node2D

var move_tween: SceneTreeTween


func _on_changed_element_focus(element_i: int, world_focus: Node2D) -> void:
	if move_tween:
		move_tween.kill()
	
	move_tween = create_tween()
	move_tween.tween_property(self, "global_position:x", world_focus.global_position.x, 0.5).set_trans(Tween.TRANS_SINE)
