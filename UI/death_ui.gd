extends CanvasLayer
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	#visible_animation()
	pass

func visible_animation():
	$AnimationPlayer.play("TextAnimation")
