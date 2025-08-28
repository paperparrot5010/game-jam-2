extends Node2D
@onready var question_layer: CanvasLayer = $Question_layer
@onready var player: CharacterBody2D = $Player
@onready var question_anim: AnimationPlayer = $question_anim
@onready var enemy_1_woman: CharacterBody2D = $enemy1_woman
@onready var death_sound: AudioStreamPlayer2D = $death
@onready var enemy_2_woman: CharacterBody2D = $enemy2_woman
@onready var animation_player: AnimationPlayer = $CanvasLayer2/AnimationPlayer


func _ready() -> void:
	player.allowed_to_move_right = false 
	player.player_jumped.connect(on_player_jumped)
	player.player_dead.connect(_on_player_dead)

	question_layer.hide()


func _on_question_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player.can_move = false 
		question_layer.show()
		question_anim.play("show_ques")
		$question.queue_free()

func _on_yes_pressed() -> void:
	question_anim.play("hide_ques")
	player.can_move = true


signal enemy_can_move
func _on_no_pressed() -> void:
	question_anim.play("hide_ques")
	await question_anim.animation_finished
	enemy_1_woman.position.x = -6.0
	enemy_1_woman.position.y = 303.0
	enemy_1_woman.show()
	enemy_can_move.emit()






func on_player_jumped():
	player.death()
var can_reload
func _on_player_dead():
	death_sound.play()
	can_reload = true
	$Timer.start()
	await $Timer.timeout
	animation_player.play("death-ani")

func _input(event: InputEvent) -> void:
	if can_reload == true && event.is_action_pressed("Enter"):
		get_tree().change_scene_to_file("res://levels/level_2.tscn")
	

func _on_attack_area_1_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		#print(1)
		player.death()
		enemy_1_woman.queue_free()
		
		enemy_2_woman.queue_free()


func _on_attack_area_2_body_entered(body: Node2D) -> void:
	pass # Replace with function body.


func _on_pass_level_2_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		TransitionScreen.color_trans()
		await TransitionScreen.on_transition_finished
		
		get_tree().change_scene_to_file("res://levels/level_3.tscn")
		print ( "reached")
