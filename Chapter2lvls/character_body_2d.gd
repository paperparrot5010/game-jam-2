extends CharacterBody2D
@onready var for_co: Area2D = $"../for_co"

#
#func _ready() -> void:
	#for_co.u_wont_take_it.connect(on_area_is_detcted)
	#
	#
#func on_area_is_detcted():
	#velocity.x = 500

func _physics_process(delta: float) -> void:
	#on_area_is_detcted()
	move_and_slide()
