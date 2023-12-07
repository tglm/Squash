
class_name Record

static var data = {
	"score": 0,
	"game_sec": 0,
	"record_time":{}
}

static func get_data(score,game_sec) -> Dictionary:
	var r = Record.new()
	data["score"] = score
	data["game_sec"] = game_sec
	data["record_time"] = Time.get_datetime_dict_from_system()
	return data
