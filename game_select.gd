extends Control

@export var quiz_button: PackedScene

var trig_questions = {}
var basic_calculus = {}
var spanish = {}

func _ready():
	get_window().min_size.x = 900
	get_window().min_size.y = 400
	var dir = DirAccess.open("res://quizzes")
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.ends_with("json"):
				print("Found quiz: " + file_name)
				var button = quiz_button.instantiate()
				var data = scramble_data(load_data("res://quizzes/" + file_name))
				button.text = file_name.trim_suffix(".json")
				button.connect("pressed", func(): button_clicked(data))
				%Quizzes.add_child(button)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	

func button_clicked(data):
	Global.questions = data
	get_tree().change_scene_to_file("res://main.tscn")

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
	data.shuffle()
	return data


func load_data(data):
	var info = load(data).data
	for i in len(info):
		info[i][0] = info[i]["0"]
		info[i][1] = info[i]["1"]
		info[i][2] = info[i]["2"]
		info[i][3] = info[i]["3"]
	return info
