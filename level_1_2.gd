extends Node2D
@onready var death_sound: AudioStreamPlayer2D = $death
var can_reload
@onready var text_for_death_ani: AnimationPlayer = $text_for_death_ani

@onready var player: CharacterBody2D = $Player

func _ready() -> void:
	player.player_dead.connect(_on_player_dead)
	#$CanvasLayer/AnimationPlayer.play("trans2-fadout")
	$DeathTimer.start()
	await $DeathTimer.timeout
	#death_sound.play()
	$Player.death()
	pass
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):

		$AnimationPlayer.play("told_u_ani")
		await get_tree().create_timer(1.5).timeout
		$AnimationPlayer.play("told_u_ani_2")
		
func _on_player_dead():
	death_sound.play()
	can_reload = true
	$Timer.start()
	await $Timer.timeout
	text_for_death_ani.play("death-text")
func _input(event: InputEvent) -> void:
	if can_reload == true && event.is_action_pressed("Enter"):
		
		get_tree().change_scene_to_file("res://levels/level_1.tscn")
