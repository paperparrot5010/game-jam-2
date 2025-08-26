extends Node2D
@onready var death_sound: AudioStreamPlayer2D = $death

@onready var player: CharacterBody2D = $Player
@onready var animation_player: AnimationPlayer = $AnimationPlayer
var can_reload
func _ready() -> void :
	player.player_jumped.connect(on_player_jumped)
	player.player_dead.connect(_on_player_dead)
func on_player_jumped():
	player.death()

func _on_player_dead():
	death_sound.play()
	can_reload = true
	$Timer.start()
	await $Timer.timeout
	animation_player.play("death-text")
func _input(event: InputEvent) -> void:
	if can_reload == true && event.is_action_pressed("Enter"):
		get_tree().reload_current_scene()


func _on_fall_tp_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") :
		TransitionScreen.color_trans()
		await TransitionScreen.on_transition_finished
	
		get_tree().change_scene_to_file("res://levels/level_2_2.tscn")
