extends Control

onready var score_label = $HBoxContainer/VBoxContainer/ScoreLabel
onready var lives_label = $HBoxContainer/VBoxContainer/LivesLabel
onready var accuracy_label = $HBoxContainer/VBoxContainer/AccLabel
onready var time_label = $HBoxContainer/VBoxContainer/TimeLabel

onready var big_time = $CenterContainer/VBoxContainer/BigTime
onready var hearts = $CenterContainer/VBoxContainer/Hearts


func _process(_delta):
	update_labels()


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


# updates hearts with a switch/match: 
# changes the minimum size of the hearts according to remaining lives,
# the Hearts texture rect in the HUD scene is set to stretch mode tile,
# which duplicates the texture according to the x and y size
func update_hearts(lives):
	match(lives):
		0:
			hearts.queue_free()
		1:
			hearts.rect_min_size.x = 90
		2:
			hearts.rect_min_size.x = 180
		3:
			hearts.rect_min_size.x = 270
		_:
			hearts.queue_free()

