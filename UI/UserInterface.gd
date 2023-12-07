extends Control

var score = 0
signal player_exited
signal cancle_pressed
var game_time_sec:int = 0

var heart_full: PackedScene = load("res://UI/heart_full.tscn")
var heart_empty: PackedScene = load("res://UI/heart_empty.tscn")

func _ready() -> void:
	
	$WarningLabel.hide()

func _unhandled_key_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		cancle_pressed.emit()
		$Retry/Label.text = "Press again to resume"



func _on_mob_squashed() -> void:
	score +=1
	$SquashPlayer.play()
	$ScoreLabel.text = "Score: %s" % score


func show_player_exit_screen_warning() -> void:
	$WarningTimer.start()
	$WarningLabel.show()

func _on_warning_timer_timeout() -> void:
	$WarningLabel.hide()
	player_exited.emit()
	
func player_entered() -> void:
	$WarningTimer.stop()
	$WarningLabel.hide()


func _on_player_hit(hp_current: int, hp_max: int) -> void:
	$HpLabel.text = 'HP: %s' % hp_current


func _on_game_timer_timeout() -> void:
	game_time_sec += 1
	game_time_sec_to_date_time(game_time_sec,5)

func game_time_sec_to_date_time(game_time_sec: int, right: int):
	$GameTimer/Label.text = Time.get_datetime_string_from_datetime_dict({"second":game_time_sec},true).right(right)
