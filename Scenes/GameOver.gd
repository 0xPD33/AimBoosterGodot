extends Control

onready var ScoreValue = $Panel/MarginContainer/TabContainer/Overview/VBoxContainer/VBoxContainer/ScoreValue
onready var BestValue = $Panel/MarginContainer/TabContainer/Overview/VBoxContainer/VBoxContainer/BestValue

var score_file = "user://highscore.data"
var highscores = []
var highscore : int = 0
var best_time : String = ""


func _ready():
	load_highscores()
	
	ScoreValue.set_text("Score: " + str(Global.score) + ", Time: " + Global.game_time)
	BestValue.set_text("Score: " + str(highscore) + ", Time: " + best_time)
	
	if Global.score > highscore or highscore == 0:
		set_highscore()
	
	Global.reset()


func set_highscore():
	best_time = Global.game_time
	highscore = Global.score
	save_highscore()
	
	BestValue.set_text("Score: " + str(highscore) + ", Time: " + best_time)

func save_highscore():
	var file = File.new()
	highscores = [highscore, best_time]
	var error = file.open(score_file, File.WRITE)
	
	if error == OK:
		file.store_var(highscores)
		file.close()
		print("Successfully saved highscore")


func load_highscores():
	var file = File.new()
	if file.file_exists(score_file):
		var error = file.open(score_file, File.READ)
		if error == OK:
			file.open(score_file, File.READ)
			var saved_highscores = file.get_var()
			highscores = saved_highscores
			file.close()
			highscore = highscores[0] 
			best_time = highscores[1]
			print("Loaded highscore")


func _on_RestartButton_pressed():
	get_tree().change_scene("res://Scenes/Game.tscn")


func _on_QuitButton_pressed():
	get_tree().change_scene("res://Scenes/MainMenu.tscn")

