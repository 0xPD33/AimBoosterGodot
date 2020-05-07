extends Timer

# timer that runs every 100 ms (0.1s) and sets the game_time accordingly

var ms = 0
var s = 0
var m = 0


func _process(_delta):
	if Global.game_over == false:
		if ms > 999:
			s += 1
			ms = 0

		if s > 59:
			m += 1
			s = 0
	
		if s < 10:
			Global.game_time = str(m) + ":" + "0" + str(s)
		else:
			Global.game_time = str(m) + ":" + str(s)
	else:
		stop_timer()


func _on_GameTimer_timeout():
	ms += 100


func stop_timer():
	stop()
	ms = 0
	s = 0
	m = 0

