extends CharacterBody2D

var speed = 200
var gravity = 13
@onready var level_2_man: Node2D = $".."
@onready var player: CharacterBody2D = $"../Player"

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var death_sound: AudioStreamPlayer2D = $death


func _ready() -> void:
	level_2_man.enemy_can_move.connect(on_enemy_can_move)

func on_enemy_can_move():
	move_right()

func _process(delta: float) -> void:
	animated_sprite_2d.play("RUN")
	
	
func _physics_process(delta: float) -> void:
	
	
	
	if not is_on_floor():
		velocity.y = gravity
	move_and_slide()
	
func move_right():
	velocity.x = -speed
