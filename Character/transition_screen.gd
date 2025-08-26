extends CanvasLayer
signal on_transition_finished
@onready var color_rect: ColorRect = $ColorRect
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	color_rect.visible = false
	animation_player.animation_finished.connect(_on_animation_finished)


func _on_animation_finished(animation_name):
	if animation_name == "Fade-in":
		on_transition_finished.emit()
		animation_player.play("Fade-out")
	if animation_name == "fade-out":
		color_rect.visible =false

func color_trans():
	color_rect.visible = true
	animation_player.play("Fade-in")


	
