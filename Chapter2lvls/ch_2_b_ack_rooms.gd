extends Node2D
@onready var r_adio_sound: AudioStreamPlayer2D = $RAdioSound
signal on_sensor_detects
var can_reload = true
@onready var death_sound: AudioStreamPlayer2D = $death
@onready var timer: Timer = $Timer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var player: CharacterBody2D = $Player
@onready var jump_scare_sound: AudioStreamPlayer2D = $JumpScare_sound
@onready var arriveanim: AnimationPlayer = $arriveanim

func _ready() -> void:
	r_adio_sound.play()
	player.player_dead.connect(_on_player_dead)
	arriveanim.play("fade")
	
	
func _on_player_dead():
	death_sound.play()
	can_reload = true
	$Timer.start()
	await $Timer.timeout
	animation_player.play("death-text")
	
func _input(event: InputEvent) -> void:
	if can_reload == true && event.is_action_pressed("Enter"):

		get_tree().change_scene_to_file("res://Chapter2lvls/ch_2_lvl_2.tscn")






func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		on_sensor_detects.emit()
		jump_scare_sound.play()


func _on_siren_head_attack_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player.death()
