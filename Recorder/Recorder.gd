extends Node

class_name Recorder

static func record(score,game_time_sec) -> void:
	var rec = Record.add(score,game_time_sec)
	var file = FileAccess.open("res://Recorder/record.json", FileAccess.WRITE)
	var json = JSON.stringify(rec,"\t")
	file.store_string(json)

