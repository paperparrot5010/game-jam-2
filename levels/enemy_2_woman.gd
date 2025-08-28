extends CharacterBody2D




var speed = 200
var gravity = 13
@onready var player: CharacterBody2D = $"../Player"
@onready var enemy_1_woman: CharacterBody2D = $"."
@onready var level_2_woman: Node2D = $".."
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D



func _ready() -> void:
	level_2_woman.enemy_can_move.connect(on_enemy_can_move)
	animated_sprite_2d.play("Run_2")

func on_enemy_can_move():
	move_right()

func _process(delta: float) -> void:
	animated_sprite_2d.play("enemy_run")
	
	
func _physics_process(delta: float) -> void:
	
	
	
	if not is_on_floor():
		velocity.y = gravity
	move_and_slide()
	
func move_right():
	velocity.x = -speed
	
	
