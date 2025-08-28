extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@onready var level_3: Node2D = $".."


var speed = 450
var gravity = 13

func _ready() -> void:
	level_3.Attack.connect(on_attack_signal_recieved)
	
	
	

func on_attack_signal_recieved():
	enemy_invasion()

func enemy_invasion():
	velocity.x = -speed
	animated_sprite_2d.play("Run_E")

func _physics_process(delta: float) -> void:
	
	
	if not is_on_floor():
		
		velocity.y += gravity
		
	move_and_slide()
