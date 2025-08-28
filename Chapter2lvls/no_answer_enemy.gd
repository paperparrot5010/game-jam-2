extends CharacterBody2D
@onready var no_answer_enemy: CharacterBody2D = $"."
var speed = 700
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D



func _ready() -> void:
	animated_sprite_2d.play("RUN")
	invisible()


func invisible():
	no_answer_enemy.set_deferred("disabled",true)
	
	no_answer_enemy.velocity = Vector2.ZERO
	no_answer_enemy.visible = false
	no_answer_enemy.process_mode = Node.PROCESS_MODE_DISABLED
	no_answer_enemy.set_deferred("monitoring",false)


func be_visible():
	no_answer_enemy.set_deferred("disabled",true)
	
	no_answer_enemy.visible = true
	
	no_answer_enemy.process_mode = Node.PROCESS_MODE_INHERIT
	no_answer_enemy.set_deferred("monitoring",true)
	
	
	
	
func _physics_process(delta: float) -> void:
	if !is_on_floor():
		velocity.y += 13
		
		
		
		
	velocity.x = speed
	move_and_slide()
