extends Node2D


func _on_r_u_man_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		TransitionScreen.color_trans()
		await TransitionScreen.on_transition_finished
		
		get_tree().change_scene_to_file("res://levels/level_2_man.tscn")
		print ( "reached")
