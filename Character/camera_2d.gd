extends Camera2D


@export var max_shake :float = 10.0
@export var shake_fade : float = 10.0
# _ : means privat variables (cannot be changed by others)
var _shake_strength :float = 0.0
# On the Camera2D node, set it to not track position


func trigger_shake():
	_shake_strength = max_shake

func _process(delta: float) -> void:
	if _shake_strength > 0 :
		_shake_strength = lerp(_shake_strength, 0.0 ,shake_fade * delta)
		offset = Vector2(randf_range(-_shake_strength , _shake_strength),randf_range(-_shake_strength , _shake_strength))
