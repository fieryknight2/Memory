extends Control

var trig_questions = {}
var basic_calculus = {}
var spanish = {}

func _ready():
	trig_questions = scramble_data(load_data("res://quizzes/trigonometry.json"))
	basic_calculus = scramble_data(load_data("res://quizzes/basic_calculus.json"))
	spanish = scramble_data(load_data("res://quizzes/spanish.json"))
	


func scramble_data(data):
	var random = RandomNumberGenerator.new()
	random.randomize()
	for q in range(len(data)):
		for i in range(3, 0, -1):
			var j = random.randi_range(0, i)
			var backup = data[q][i]
			data[q][i] = data[q][j]
			data[q][j] = backup
		# Find the answer
		var ans = data[q][str(data[q]["answer"])]
		if ans == data[q][0]:
			data[q]["answer"] = 0
		elif ans == data[q][1]:
			data[q]["answer"] = 1
		elif ans == data[q][2]:
			data[q]["answer"] = 2
		elif ans == data[q][3]:
			data[q]["answer"] = 3
	return data


func load_data(data):
	var info = load(data).data
	for i in len(info):
		info[i][0] = info[i]["0"]
		info[i][1] = info[i]["1"]
		info[i][2] = info[i]["2"]
		info[i][3] = info[i]["3"]
	return info


func _on_trigonometry_pressed() -> void:
	Global.questions = trig_questions
	get_tree().change_scene_to_file("res://main.tscn")


func _on_spanish_pressed() -> void:
	Global.questions = spanish
	get_tree().change_scene_to_file("res://main.tscn")
	

func _on_basic_calculus_pressed() -> void:
	Global.questions = basic_calculus
	get_tree().change_scene_to_file("res://main.tscn")
