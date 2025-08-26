extends CharacterBody2D
var speed = 200
var gravity = 13
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D




func _process(delta: float) -> void:
	animated_sprite_2d.play("enemy_run")
	
	
func _physics_process(delta: float) -> void:
	velocity.x = speed
	
	if not is_on_floor():
		velocity.y = gravity
	move_and_slide()


func _on_attack_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		Player_g.death()
		pass
