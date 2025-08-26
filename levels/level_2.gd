extends Node2D
@onready var player: CharacterBody2D = $Player
@onready var animation_player: AnimationPlayer = $AnimationPlayer
var can_reload
func _ready() -> void :
	player.player_jumped.connect(on_player_jumped)
	player.player_dead.connect(_on_player_dead)
func on_player_jumped():
	player.death()

func _on_player_dead():
	can_reload = true
	$Timer.start()
	await $Timer.timeout
	animation_player.play("death-text")
func _input(event: InputEvent) -> void:
	if can_reload == true && event.is_action_pressed("Enter"):
		get_tree().reload_current_scene()
