extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var death_sound: AudioStreamPlayer2D = $death
@onready var animation_player_death: AnimationPlayer = $CanvasLayer2/AnimationPlayer
#@onready var character_body_2d: CharacterBody2D = $CharacterBody2D
@onready var character_body_2d_2: CharacterBody2D = $CharacterBody2D2
@onready var replay_sound: AudioStreamPlayer2D = $"replay sound"
@onready var enemy_2: CharacterBody2D = $enemy2


func _ready() -> void:
	player.allowed_to_move_left = false
	player.player_jumped.connect(on_player_jumped)
	player.player_dead.connect(_on_player_dead)
	

	canvas_layer.hide()
	character_body_2d_2.hide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player.can_move = false 
		canvas_layer.show()
		animation_player.play("r u ?")
		$Area2D.queue_free()

		

signal enemy_can_move
func _on_no_pressed() -> void:
	animation_player.play("r u ?_reverse")
	await animation_player.animation_finished
	character_body_2d_2.position.x = -6.0
	character_body_2d_2.position.y = 303.0
	character_body_2d_2.show()
	enemy_can_move.emit()
	
	


func on_player_jumped():
	player.death()
var can_reload
func _on_player_dead():
	death_sound.play()
	can_reload = true
	$Timer.start()
	await $Timer.timeout
	animation_player_death.play("death-ani")
	

func _input(event: InputEvent) -> void:
	if can_reload == true && event.is_action_pressed("Enter"):
		get_tree().change_scene_to_file("res://levels/level_2.tscn")


func _on_deatharea_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		#print(1)
		player.death()
		character_body_2d_2.queue_free()
		
		enemy_2.queue_free()
		


func _on_yes_pressed() -> void:
		player.can_move = true
		
		animation_player.play("r u ?_reverse")


#func _on_death_area_2_body_entered(body: Node2D) -> void:
	#if body.is_in_group("Player"):
		#enemy_2.queue_free()


func _on_pass_level_2_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		TransitionScreen.color_trans()
		await TransitionScreen.on_transition_finished
		
		get_tree().change_scene_to_file("res://levels/level_3.tscn")
		print ( "reached")
