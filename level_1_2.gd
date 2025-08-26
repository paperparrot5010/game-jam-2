extends Node2D


func _ready() -> void:
	#$CanvasLayer/AnimationPlayer.play("trans2-fadout")
	$DeathTimer.start()
	await $DeathTimer.timeout
	$Player.death()
	pass
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):

		$AnimationPlayer.play("told_u_ani")
		await get_tree().create_timer(2.0).timeout
		$AnimationPlayer.play("told_u_ani_2")
		
