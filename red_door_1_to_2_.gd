extends Area2D





@onready var animation_player: AnimationPlayer = $AnimationPlayer

signal player_entred_door

@export var target_scene : PackedScene

func _ready() -> void:
	animation_player.play("Opening_anim")

func next_level():
	var ERR = get_tree().change_scene_to_packed(target_scene)

	if ERR:
		if ERR != OK:
			print("something failed")
		












func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") :
		GlobalRedTransition.color_trans()
		await GlobalRedTransition._on_animation_finished
		next_level()
