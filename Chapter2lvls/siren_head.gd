extends CharacterBody2D


var speed = 800
var gravity = 13
@onready var ch_2_b_ack_rooms: Node2D = $".."

func _ready() -> void:
	ch_2_b_ack_rooms.on_sensor_detects.connect(_sensor_detected)
func _sensor_detected():
	move_right()
func _physics_process(delta: float) -> void:
	if !is_on_floor():
		velocity.y += gravity
		
	
	move_and_slide()
	


func move_right():
	velocity. x += speed
