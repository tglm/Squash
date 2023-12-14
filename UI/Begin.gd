extends Node2D




func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Main.tscn")


func _on_exit_button_pressed() -> void:
	get_tree().quit()
	
func _ready() -> void:
	$CharacterBody2D.position = $Marker2D.position


func _on_start_zone_area_entered(area: Area2D) -> void:
	$ColorRect/StartZone/StartTimer.start()


func _on_start_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Main.tscn")



func _on_record_zone_area_entered(area: Area2D) -> void:
	$ColorRect/RecordZone/RecordTimer.start()


#todo
func _on_record_timer_timeout() -> void:
	pass
