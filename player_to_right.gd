extends CharacterBody2D
var speed = 559
func _ready() -> void:
	move_right()
	
	move_and_slide()

	
func move_right():
	velocity.x = speed 
