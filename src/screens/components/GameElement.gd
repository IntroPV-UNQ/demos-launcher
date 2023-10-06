tool
extends Control

onready var follow_pivot: Node2D = $"%FollowPivot"

export (String) var game_route: String
export (bool) var is_local: bool = true
export (String) var game_folder: String

export (String) var game_title: String setget _set_game_title
export (String) var game_team: String setget _set_game_team
export (String) var game_members: String setget _set_game_members
export (Array, Texture) var game_previews: Array setget _set_game_previews


func _set_game_title(title: String) -> void:
	game_title = title
	if has_node("%GameTitleLabel"):
		$"%GameTitleLabel".text = title


func _set_game_team(team: String) -> void:
	game_team = team
	if has_node("%GameTeamLabel"):
		$"%GameTeamLabel".text = team


func _set_game_members(members: String) -> void:
	game_members = members
	if has_node("%GameMembersLabel"):
		$"%GameMembersLabel".text = members


func _set_game_previews(previews: Array) -> void:
	game_previews = previews
	if has_node("%GamePreviewTexture"):
		var texture_rect: TextureRect = $"%GamePreviewTexture"
		var parent: Node = texture_rect.get_parent()
		for child in parent.get_children():
			if child != texture_rect:
				parent.remove_child(child)
				child.queue_free()
		if previews.empty():
			texture_rect.texture = null
		else:
			texture_rect.texture = previews[0]
			for preview_i in range(1, previews.size()):
				var text_copy: TextureRect = texture_rect.duplicate(0)
				text_copy.texture = previews[preview_i]
				parent.add_child(text_copy)

