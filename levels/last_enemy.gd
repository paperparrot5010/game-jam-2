extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var last_enemy: CharacterBody2D = $"."
@onready var last_enemy_attack: Area2D = $last_enemy_attack
var speed = 800
var gravity = 13

func _ready() -> void:
	animated_sprite_2d.play("Run_last")
	invisible()
	
func invisible():
	last_enemy.set_deferred("disabled",true)
	
	last_enemy.velocity = Vector2.ZERO
	last_enemy.visible = false
	last_enemy.process_mode = Node.PROCESS_MODE_DISABLED
	last_enemy_attack.set_deferred("monitoring",false)


func be_visible():
	last_enemy.set_deferred("disabled",true)
	
	last_enemy.visible = true
	
	last_enemy.process_mode = Node.PROCESS_MODE_INHERIT
	last_enemy_attack.set_deferred("monitoring",true)

func _physics_process(delta: float) -> void:
	if !is_on_floor():
		velocity.y += 13
		
		
		
		
	velocity.x = speed
	move_and_slide()
