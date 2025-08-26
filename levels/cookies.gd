extends Area2D

signal activate

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		emit_signal("activate")
		queue_free()
