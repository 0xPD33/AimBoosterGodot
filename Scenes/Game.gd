extends Node2D

onready var score_label = $HUD/HBoxContainer/VBoxContainer/ScoreLabel
onready var lives_label = $HUD/HBoxContainer/VBoxContainer/LivesLabel
onready var accuracy_label = $HUD/HBoxContainer/VBoxContainer/AccLabel
onready var time_label = $HUD/HBoxContainer/VBoxContainer/TimeLabel


# calls these every frame
func _process(_delta):
	update_labels()
	check_lives()
	count_clicks()
	calc_accuracy()


# updates labels as the game goes on
func update_labels():
	score_label.text = "Score: " + str(Global.score)
	lives_label.text = "Lives: " + str(Global.lives)
	accuracy_label.text = "Accuracy: " + str(Global.accuracy) + "%"
	time_label.text = "Time: " + str(Global.game_time)
	
	hide_and_show_labels()


# hide or show the labels, depending on game_over value,
# probably not necessary because the scene get's restarted on change_scene anyway
func hide_and_show_labels():
	if Global.game_over == true:
		score_label.visible = false
		lives_label.visible = false
		accuracy_label.visible = false
		time_label.visible = false
	else:
		score_label.visible = true
		lives_label.visible = true
		accuracy_label.visible = true
		time_label.visible = true


func count_clicks():
	if Global.game_over == false:
		if Input.is_action_just_pressed("Click"):
			Global.clicks += 1


# calculates the accuracy if hit_clicks and clicks are above 0
func calc_accuracy():
	if Global.game_over == false:
		if Global.hit_clicks > 0 and Global.clicks > 0:
			Global.accuracy = Global.hit_clicks * 100 / Global.clicks 
		else:
			pass


func check_lives():
	if Global.lives <= 0:
		end_game()


# end the game and change to GameOver scene
func end_game():
	Global.game_over = true
	get_tree().change_scene("res://Scenes/GameOver.tscn")

