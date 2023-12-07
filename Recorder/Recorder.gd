extends Node

class_name Recorder

static func record(score,game_time_sec) -> void:
	var read_file = FileAccess.open("res://Recorder/record.json", FileAccess.READ)
	var old_record = read_file.get_as_text()
	read_file.close()
	
	var rec = Record.get_data(score,game_time_sec)
	var file = FileAccess.open("res://Recorder/record.json", FileAccess.WRITE_READ)
	var new_record = JSON.stringify(rec,"\t")
	file.store_string(old_record +",\t" + new_record)
	file.close()
