extends Node2D

@export var mob_scene: PackedScene


func _ready() -> void:
	$UserInterface/Retry.hide()

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_pressed("ui_accept") and $UserInterface/Retry.visible:
		get_tree().reload_current_scene()
		$"/root/MusicPlayer".play()

func _on_mob_timer_timeout() -> void:
	mob_spawn()


func mob_spawn() -> void:
	
	var mob = mob_scene.instantiate()
	var mob_spawn_location = $SpawnPath/SpawnLocation
	mob_spawn_location.progress_ratio = randf()
	var start_position = mob_spawn_location.position
	var player_position = $Player.position
	mob.initialize(start_position,player_position)
	
	
	mob.squashed.connect($UserInterface._on_mob_squashed)
	
	add_child(mob)

func _on_player_dead() -> void:
	Recorder.record($UserInterface.score,$UserInterface.game_time_sec)
	$MobTimer.stop()
	$UserInterface/Retry/Label.text = "Enter to retry"
	$UserInterface/Retry.show()

func _on_player_exit_screen() -> void:
	$UserInterface.show_player_exit_screen_warning()

func _on_user_interface_player_exited() -> void:
	_on_player_dead()

func _on_player_enter_screen() -> void:
	$UserInterface.player_entered()


func _on_user_interface_cancle_pressed() -> void:
	$Player.set_process_input(not $Player.is_processing_input())
	$UserInterface/Retry.visible = not $UserInterface/Retry.visible
	if $MobTimer.is_stopped():
		$MobTimer.start()
	else: $MobTimer.stop()
