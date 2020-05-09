extends Area2D

# if true, slow down (*0.5) the shrinking and growing speed of the target
var slow_down : bool = false
# if true shrink the target, if false target is growing
var shrinking : bool = false


func _process(delta):
	shrink_and_grow_target(slow_down, shrinking, delta)
	check_scale()


# runs when you click a target
func _on_Target_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed() and Global.game_over == false:
			destroy_target()
			Global.play_sound("res://SFX/click.wav")


# shrink and grow targets
func shrink_and_grow_target(sd, shrink, delta):
	# shrink or grow target according to scale.x and scale.y values and apply slowdown
	if shrink == false:
		if sd == false:
			scale.x += Global.shrink_grow_strength * delta
			scale.y += Global.shrink_grow_strength * delta
		elif sd == true:
			scale.x += Global.shrink_grow_strength * Global.slowdown_strength * delta
			scale.y += Global.shrink_grow_strength * Global.slowdown_strength * delta
	elif shrink == true:
		if sd == false:
			scale.x -= Global.shrink_grow_strength * delta
			scale.y -= Global.shrink_grow_strength * delta
		elif sd == true:
			scale.x -= Global.shrink_grow_strength * Global.slowdown_strength * delta
			scale.y -= Global.shrink_grow_strength * Global.slowdown_strength * delta
	
	if scale.x <= 0.01 and scale.y <= 0.01:
		despawn_target()


func check_scale():
	if scale.x >= 1 and scale.y >= 1:
		shrinking = true


# slowdown target when the mouse has entered
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

