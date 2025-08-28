extends Node2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var get_area: Area2D = $get_area
@onready var get_cookie: AnimationPlayer = $getCookie
@onready var wall_animation: AnimationPlayer = $"Wall animation"
@onready var detect_for_wall_2: Area2D = $DetectForWall2
@onready var wall_2_animation: AnimationPlayer = $Wall2Animation
@onready var wall_sound: AudioStreamPlayer2D = $WallSound
@onready var wall_2_sound_timer: Timer = $Wall2_soundTimer
@onready var wall_1_sound_timer: Timer = $Wall1_soundTimer
@onready var wall_2_sound: AudioStreamPlayer2D = $Wall2_sound
@onready var player: CharacterBody2D = $Player
var can_reload: bool 
@onready var death_sound: AudioStreamPlayer2D = $death
@onready var timer: Timer = $Timer
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	detect_for_wall_2.set_deferred("monitoring",false)
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
		get_tree().change_scene_to_file("res://Chapter2lvls/ch_2_lvl_1.tscn")









func _on_fake_cookie_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		wall_1_sound_timer.start()
		sprite_2d.queue_free()
		get_area.queue_free()
		wall_animation.play("Wall")
		detect_for_wall_2.set_deferred("monitoring",true)
		wall_sound.play()
		await wall_1_sound_timer.timeout
		wall_sound.stop()

func _on_get_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		get_cookie.play("get_cookie_ani")
		
		

func _on_get_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		get_cookie.play("get_cookie_ani_inverted")
		
		
		


func _on_detect_for_wall_2_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		wall_2_sound_timer.start()
		wall_2_animation.play("Wall2down")
		detect_for_wall_2.queue_free()
		
		wall_2_sound.play()
		await wall_2_sound_timer.timeout
		wall_2_sound.stop()
		


func _on_killer_wall_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player.death()
