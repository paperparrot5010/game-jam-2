extends CanvasLayer
@onready var orange_rect: ColorRect = $orange_rect
@onready var orange_rect_anim: AnimationPlayer = $orange_rect_anim
signal _on_orange_transition_finished

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	orange_rect.visible = false
	orange_rect_anim.animation_finished.connect(_on_orange_animatin_finished)
	
func orange_transition():
	orange_rect.visible = true
	orange_rect_anim.play("fade-in-orange")
	
func _on_orange_animatin_finished(animation_name):
	if animation_name == "fade-in-orange":
		_on_orange_transition_finished.emit()
		orange_rect_anim.play("fade-out-orange")
	if animation_name == "fade-out-orange":
		orange_rect.visible = false
