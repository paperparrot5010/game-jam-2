extends Node2D

@onready var goanim: AnimationPlayer = $goanim
@export var opened_door_scene :PackedScene
@onready var replay_sound: AudioStreamPlayer2D = $"replay sound"
@onready var empty_doors_node: Node2D = $DOORS



func _ready() -> void:
	replay_sound.play()
	var cookie = find_child("Cookies")
	if cookie :
		cookie.activate.connect(self._when_cookie_collected)
		
		

func _when_cookie_collected():
	if opened_door_scene :
		var door_instantiation = opened_door_scene.instantiate()
		empty_doors_node.add_child(door_instantiation)
		door_instantiation.position = Vector2(175.0,288.0)













func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		goanim.play("fade")
		await goanim.animation_finished
		
		
		get_tree().change_scene_to_file("res://Chapter2lvls/ch_2_b_ack_rooms.tscn")
