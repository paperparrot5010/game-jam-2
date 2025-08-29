extends Node2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var player: CharacterBody2D = $Player
@onready var death_sound: AudioStreamPlayer2D = $death
@onready var replay_sound: AudioStreamPlayer2D = $"replay sound"
var can_reload: bool
@onready var moving_ground: StaticBody2D = $MovingGround
@onready var moving_ground_2: StaticBody2D = $MovingGround2
@export var opened_door_scene :PackedScene
@onready var empty_doors_node = $DOORS
@onready var cookies: Area2D = $Cookies










func _ready() -> void:
	replay_sound.play()
	player.player_dead.connect(_on_player_dead)
	var cookie = find_child("Cookies")
	if cookie :
		cookie.activate.connect(self._when_cookie_collected)
		
		
func _when_cookie_collected():
	if opened_door_scene :
		var door_instantiation = opened_door_scene.instantiate()
		empty_doors_node.add_child(door_instantiation)
		door_instantiation.position = Vector2(161.0,354.0)
		$RedOpeningDoor.queue_free()



func _on_player_dead():
	death_sound.play()
	can_reload = true
	$Timer.start()
	await $Timer.timeout
	animation_player.play("death-text")
func _input(event: InputEvent) -> void:
	if can_reload == true && event.is_action_pressed("Enter"):
		get_tree().reload_current_scene()


func _on_fall_death_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player.death()


func _on_area_2d_moving_ground_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		moving_ground.position.x = 300
		


func _on_area_2d_moving_2_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		if moving_ground_2:
			moving_ground_2.queue_free()


func _on_moving_cookies_are_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		if cookies :
			cookies.position.x = 293.0
