extends Node2D
@onready var question_anim: AnimationPlayer = $QuestionAnim
@onready var when_yes_area: Area2D = $when_yes_area
@onready var sudden_enemy: CharacterBody2D = $Sudden_Enemy
@onready var wall_anim: AnimationPlayer = $Sprite2D/WallAnim
@export var opened_door_scene :PackedScene
@onready var player: CharacterBody2D = $Player
@onready var area_2d: Area2D = $Area2D
@onready var disable_area_timer: Timer = $"disable area timer"

@onready var empty_doors_node = $DOORS
@onready var no_answer_enemy: CharacterBody2D = $NO_answer_enemy
var can_reload : bool
@onready var death_sound: AudioStreamPlayer2D = $death
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var wall_move_detection_area: Area2D = $WallMoveDetectionArea
@onready var wall_soundtimer: Timer = $WallSoundtimer
@onready var wood_block_3: AudioStreamPlayer = $WoodBlock3





func _ready() -> void:

	when_yes_area.set_deferred("monitoring",false)
	wall_move_detection_area.set_deferred("monitoring",false)

	
	player.player_dead.connect(_on_player_dead)
	$"replay sound".play()
	var cookie = find_child("Cookies")
	if cookie :
		cookie.activate.connect(self._when_cookie_collected)
	

	
func _when_cookie_collected():
	if opened_door_scene :
		var door_instantiation = opened_door_scene.instantiate()
		empty_doors_node.add_child(door_instantiation)
		door_instantiation.position = Vector2(1043.0,546.0)
		when_yes_area.set_deferred("monitoring",true)
		wall_move_detection_area.set_deferred("monitoring",true)



func _on_player_dead():
	death_sound.play()
	can_reload = true
	$Timer.start()
	await $Timer.timeout
	animation_player.play("death-text")


func _input(event: InputEvent) -> void:
	if can_reload == true && event.is_action_pressed("Enter"):
		get_tree().change_scene_to_file("res://Chapter2lvls/ch_2_lvl_1.tscn")


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):

		
		question_anim.play("question")
		player.can_move = false
		
		area_2d.queue_free()





#yes and no button :




func _on_enemy_attack_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player.death()
		no_answer_enemy.queue_free()
		print("no answer enemy")


func _on_when_yes_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		when_yes_area.queue_free()
		sudden_enemy.be_visible()
		


func _on_area_2d_sudde_e_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player.death()
		sudden_enemy.queue_free()
		print("the sudden enemy")


func _on_wall_move_detection_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		$Moving_wall/WallAnim.play("Wall_to_rgiht")
		wall_soundtimer.start()
		wood_block_3.play()
		wall_move_detection_area.queue_free()
		await wall_soundtimer.timeout
		wood_block_3.stop()


func _on_yes_button_pressed() -> void:
	question_anim.play("question_disappear")
	player.can_move = true
	
	
	



	






func _on_no_button_pressed() -> void:
	question_anim.play("question_disappear")
	no_answer_enemy.be_visible()
