extends Node2D

@export var opened_door_scene :PackedScene
@onready var empty_doors_node = $DOORS

func _ready() -> void:
	var cookie = find_child("Cookies")
	if cookie :
		cookie.activate.connect(self._when_cookie_collected)
		
		
func _when_cookie_collected():
	if opened_door_scene :
		var door_instantiation = opened_door_scene.instantiate()
		empty_doors_node.add_child(door_instantiation)
		door_instantiation.position = Vector2(97.0,288.0)
		$LockedDoor.queue_free()



		


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		$AnimationPlayer.play("no_imp")
		$Area2D.queue_free()


func _on_fall_tp_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") :
		TransitionScreen.color_trans()
		await TransitionScreen.on_transition_finished
	
		get_tree().change_scene_to_file("res://levels/level_1_2.tscn")
