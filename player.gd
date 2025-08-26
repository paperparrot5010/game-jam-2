extends CharacterBody2D
var speed = 200
var gravity = 13
var jump = 300
@onready var jump_sound: AudioStreamPlayer2D = $Jump
@onready var coyote_timer: Timer = $CoyoteTimer
@export var Deathparticles : PackedScene
@onready var camera : Camera2D = get_tree().get_first_node_in_group("Camera")
func _physics_process(_delta: float) -> void:
	#Move right:
	if Input.is_action_pressed("r"):
		$AnimatedSprite2D.flip_h = false
		velocity.x = speed 
		#Move left:
	elif Input.is_action_pressed("l"):
		$AnimatedSprite2D.flip_h = true
		velocity.x = -speed 
		#Stop
	else :
		velocity.x = 0
	#Animations :
	
	if not is_on_floor():
		
		if velocity.y <0 :
			$AnimatedSprite2D.play("JUMP")
		#if velocity.y >0 :
		#	$AnimatedSprite2D.play("JUMP")
	if is_on_floor():
		if velocity.x != 0:
			$AnimatedSprite2D.play("RUN")
		if velocity.x == 0:
			$AnimatedSprite2D.play("IDLE")
		
		
	#Applying gravity:
	if not is_on_floor():
		velocity.y += gravity
	#Jump:
	jumping()
		
	
	var was_on_floor = is_on_floor()
	move_and_slide()
	
	var just_left_ledge = was_on_floor and !is_on_floor() and velocity.y >= 0
	if just_left_ledge :
		coyote_timer.start()
signal player_dead()
func death():
	#understand what is below
	var _particle = Deathparticles.instantiate()
	_particle.position = global_position
	_particle.rotation = global_rotation
	_particle.emitting = true
	get_tree().current_scene.add_child(_particle)
	$"../Camera2D".screen_shake(5 , 1)
	queue_free()
	player_dead.emit()


signal player_jumped()

func jumping():
	if is_on_floor() or coyote_timer.time_left > 0:
		if Input.is_action_just_pressed("u"):
			jump_sound.play()
			velocity.y = -jump
			player_jumped.emit()  # Emit signal when jump occurs
	
