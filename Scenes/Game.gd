extends Node2D


# calls these every frame
func _process(_delta):
	check_lives()
	count_clicks()


func count_clicks():
	calc_accuracy()
	if Global.game_over == false:
		if Input.is_action_just_pressed("Click"):
			Global.clicks += 1
			calc_accuracy()


# calculates the accuracy if hit_clicks and clicks are above 0
func calc_accuracy():
	if Global.game_over == false:
		if Global.hit_clicks > 0 and Global.clicks > 0:
			Global.accuracy = Global.hit_clicks * 100 / Global.clicks 
		else:
			pass


# checks for lives, updates the HUD and ends the game
func check_lives():
	update_hud()
	if Global.lives <= 0:
		end_game()


# experimenting with groups: calling update_labels from the HUD script
func update_hud():
	get_tree().call_group("HUD", "update_hearts", Global.lives)


# end the game and change to GameOver scene
func end_game():
	Global.game_over = true
	get_tree().change_scene("res://Scenes/GameOver.tscn")

