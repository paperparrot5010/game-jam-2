extends Area2D

@export var target_scene : PackedScene


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") :

		TransitionScreen.color_trans()
		await TransitionScreen.on_transition_finished
		next_level()
func next_level():
	var ERR = get_tree().change_scene_to_packed(target_scene)

	if ERR:
		if ERR != OK:
			print("something failed")
		
