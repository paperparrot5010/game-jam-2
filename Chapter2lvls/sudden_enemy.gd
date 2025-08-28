extends CharacterBody2D
@onready var sudden_enemy: CharacterBody2D = $"."
var speed = 800
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D



func _ready() -> void:
	animated_sprite_2d.play("RUN")
	invisible()


func invisible():
	sudden_enemy.set_deferred("disabled",true)
	
	sudden_enemy.velocity = Vector2.ZERO
	sudden_enemy.visible = false
	sudden_enemy.process_mode = Node.PROCESS_MODE_DISABLED
	sudden_enemy.set_deferred("monitoring",false)


func be_visible():
	sudden_enemy.set_deferred("disabled",true)
	
	sudden_enemy.visible = true
	
	sudden_enemy.process_mode = Node.PROCESS_MODE_INHERIT
	sudden_enemy.set_deferred("monitoring",true)
	
	
	
	
func _physics_process(delta: float) -> void:
	if !is_on_floor():
		velocity.y += 13
		
		
		
		
	velocity.x = -speed
	move_and_slide()
