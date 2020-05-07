extends Area2D

# if true, slow down (*0.5) the shrinking speed of the target
var slow_down : bool = false


func _process(delta):
	shrink_target(slow_down, delta)


# runs when you click a target
func _on_Target_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed() and Global.game_over == false:
			destroy_target()
			Global.play_sound("res://SFX/click.wav")


# shrink targets
func shrink_target(sd, delta):
	if sd == false:
		# targets automatically despawn after having their scale reduced to 0.05
		if scale.x and scale.y > 0.05:
			scale.x -= Global.shrink_strength * delta
			scale.y -= Global.shrink_strength * delta
		else:
			despawn_target()
	
	# slow down target when the mouse has entered the target
	elif sd == true:
		scale.x -= Global.shrink_strength * Global.slowdown_strength * delta
		scale.y -= Global.shrink_strength * Global.slowdown_strength * delta


func _on_Target_mouse_entered():
	slow_down = true


func _on_Target_mouse_exited():
	slow_down = false


# remove a target from the scene upon clicking it and increase your score
func destroy_target():
	queue_free()
	Global.hit_clicks += 1
	Global.score += 1


# upon missing the target you lose a life
func despawn_target():
	queue_free()
	Global.lives -= 1

