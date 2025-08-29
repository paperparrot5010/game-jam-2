extends Node2D

#Main var :
@onready var replay_sound: AudioStreamPlayer2D = $"replay sound"
@onready var player: CharacterBody2D = $Player
@export var opened_door_scene :PackedScene
@onready var empty_doors_node = $DOORS
@onready var death_sound: AudioStreamPlayer2D = $death
var can_reload: bool 
@onready var animation_player: AnimationPlayer = $AnimationPlayer
#Additions :
@onready var cookies: Area2D = $Cookies
@onready var red_opening_door: Sprite2D = $RedOpeningDoor
@onready var animation_player_for_wall: AnimationPlayer = $Falling_block/AnimationPlayer
@onready var fallingwall_detection_area: Area2D = $FallingwallDetectionArea
@onready var switch_places: Area2D = $SwitchPlaces



func _ready() -> void:
	#Main:
	replay_sound.play()
	player.player_dead.connect(_on_player_dead)
	var cookie = find_child("Cookies")
	if cookie :
		cookie.activate.connect(self._when_cookie_collected)
	#Additions:
	fallingwall_detection_area.set_deferred("monitoring",false)



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




func _on_falldeath_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player.death()


func _on_switch_places_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		cookies.position.x = 161
		red_opening_door.position.x = 938
		fallingwall_detection_area.set_deferred("monitoring",true)
		switch_places.queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player.death()

func _on_fallingwall_detection_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		animation_player_for_wall.play("FallingBlockAnim")
		fallingwall_detection_area.queue_free()
