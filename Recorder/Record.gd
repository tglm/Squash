extends Node

class_name Record

var score:int = 0
var game_sec:int = 0
var record_time:Dictionary

static func add(scoree,game_secc) -> Record:
	var r = Record.new()
	r.score = scoree
	r.game_sec = game_secc
	r.record_time = Time.get_datetime_dict_from_system()
	return r
	
