extends Node2D
@onready var player: CharacterBody2D = $Player
@onready var moving_cookies: CharacterBody2D = $moving_cookies


func _ready() -> void:
	pass

signal u_wont_take_it
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		moving_cookies.velocity = Vector2(500,0)


func _on_down_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		#TransitionScreen.color_trans()
		#await TransitionScreen.on_transition_finished
		GlobalOrangeTransitionScreen.orange_transition()
		await GlobalOrangeTransitionScreen._on_orange_transition_finished
		get_tree().change_scene_to_file("res://Chapter2lvls/ch_2_lvl_1_2.tscn")

func _on_right_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		GlobalOrangeTransitionScreen.orange_transition()
		await GlobalOrangeTransitionScreen._on_orange_transition_finished
		get_tree().change_scene_to_file("res://ch_2_lvl_1_3.tscn")
