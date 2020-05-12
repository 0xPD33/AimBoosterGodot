extends Node2D

onready var score_label = $HUD/HBoxContainer/VBoxContainer/ScoreLabel
onready var lives_label = $HUD/HBoxContainer/VBoxContainer/LivesLabel
onready var accuracy_label = $HUD/HBoxContainer/VBoxContainer/AccLabel
onready var time_label = $HUD/HBoxContainer/VBoxContainer/TimeLabel

onready var big_time = $HUD/CenterContainer/VBoxContainer/BigTime
onready var hearts = $HUD/CenterContainer/VBoxContainer/Hearts


# calls these every frame
func _process(_delta):
	update_labels()
	check_lives()
	count_clicks()


# updates labels as the game goes on
func update_labels():
	score_label.text = "Score: " + str(Global.score)
	lives_label.text = "Lives: " + str(Global.lives)
	accuracy_label.text = "Accuracy: " + str(Global.accuracy) + "%"
	time_label.text = "Time: " + str(Global.game_time)
	
	big_time.text = str(Global.game_time)
	
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


# checks for lives with a switch/match: 
# changes the minimum size of the hearts according to remaining lives,
# the Hearts texture rect in the HUD scene is set to stretch mode tile,
# which duplicates the texture according to the x and y size
func check_lives():
	match(Global.lives):
		0:
			hearts.queue_free()
			end_game()
		1:
			hearts.rect_min_size.x = 90
		2:
			hearts.rect_min_size.x = 180
		3:
			hearts.rect_min_size.x = 270


# end the game and change to GameOver scene
func end_game():
	Global.game_over = true
	get_tree().change_scene("res://Scenes/GameOver.tscn")

