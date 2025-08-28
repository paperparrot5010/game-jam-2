extends Node2D

signal Attack
@onready var death_sound: AudioStreamPlayer2D = $death
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var last_trap: Area2D = $Last_trap
@onready var last_enemy: CharacterBody2D = $Last_enemy
@onready var character_body_2d: CharacterBody2D = $CharacterBody2D
@onready var curious_animation_player: AnimationPlayer = $"CanvasLayer2/curious animation player"
@onready var curious_area: Area2D = $"curious area"

var can_reload
@export var opened_door_scene :PackedScene
@onready var empty_doors_node = $DOORS
@onready var player: CharacterBody2D = $Player

func _ready() -> void:
	last_trap.set_deferred("monitoring",false)
	
	player.player_dead.connect(_on_player_dead)

	$"replay sound".play()
	var cookie = find_child("Cookies")
	if cookie :
		cookie.activate.connect(self._when_cookie_collected)
		
		
func _when_cookie_collected():
	if opened_door_scene :
		var door_instantiation = opened_door_scene.instantiate()
		empty_doors_node.add_child(door_instantiation)
		door_instantiation.position = Vector2(175.0,288.0)


func _on_enemy_attack_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player.death()
		character_body_2d.queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		Attack.emit()
		last_trap.set_deferred("monitoring",true)


func _on_death_line_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		
		player.death()
		







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


func _on_en_dis_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		sprite_2d.queue_free()


func _on_last_trap_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print(1)
		last_enemy.be_visible()


func _on_last_enemy_attack_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player.death()
		last_enemy.queue_free()


func _on_curious_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		curious_animation_player.play("curious?")
		curious_area.queue_free()
