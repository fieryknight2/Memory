extends Control

@export var qdisplay: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var answers = [0, 0, 0, 0]
	var correct = [0, 0, 0, 0]
	for i in range(Global.responses.size()):
		var value = Global.responses[i]
		if value != -1:
			answers[value] += 1
		if value == Global.questions[i]["answer"]:
			correct[value] += 1
	
	%OptionA.find_child("Answers").max_value = answers[0]
	%OptionA.find_child("Answers").value = correct[0]
	
	%OptionB.find_child("Answers").max_value = answers[1]
	%OptionB.find_child("Answers").value = correct[1]
	
	%OptionC.find_child("Answers").max_value = answers[2]
	%OptionC.find_child("Answers").value = correct[2]
	
	%OptionD.find_child("Answers").max_value = answers[3]
	%OptionD.find_child("Answers").value = correct[3]
	
	if answers[0] != 0:
		%OptionA.find_child("Label").text = "A - " + str(round(float(correct[0]) / answers[0] * 100)) + "%"
	if answers[1] != 0:
		%OptionB.find_child("Label").text = "B - " + str(round(float(correct[1]) / answers[1] * 100)) + "%"
	if answers[2] != 0:
		%OptionC.find_child("Label").text = "C - " + str(round(float(correct[2]) / answers[2] * 100)) + "%"
	if answers[3] != 0:
		%OptionD.find_child("Label").text = "D - " + str(round(float(correct[3]) / answers[3] * 100)) + "%"
	
	update_answers_size()
	
	var total: float = correct[0] + correct[1] + correct[2] + correct[3]
	%Progress.max_value = Global.questions.size()
	%Progress.value = total
	
	var percent = round((total / len(Global.questions)) * 100)
	print(percent)
	var grade = "F"
	if percent >= 90:
		grade = "A"
	elif percent >= 80:
		grade = "B"
	elif percent >= 70:
		grade = "C"
	elif percent >= 60:
		grade = "D"
	%Grade.text = grade + " - " + str(percent) + "%"
	
	for i in range(Global.questions.size()):
		var display = qdisplay.instantiate()
		display.question = Global.questions[i]
		display.response = Global.responses[i]
		%Questions.add_child(display)
		

func update_answers_size():
	var max_size = get_viewport_rect().size.x * 0.7
	%OptionA.find_child("Answers").custom_minimum_size = Vector2(clamp((%OptionA.find_child("Answers").max_value / Global.questions.size()) * max_size, 0, max_size), 30)
	%OptionB.find_child("Answers").custom_minimum_size = Vector2(clamp((%OptionB.find_child("Answers").max_value / Global.questions.size()) * max_size, 0, max_size), 30)
	%OptionC.find_child("Answers").custom_minimum_size = Vector2(clamp((%OptionC.find_child("Answers").max_value / Global.questions.size()) * max_size, 0, max_size), 30)
	%OptionD.find_child("Answers").custom_minimum_size = Vector2(clamp((%OptionD.find_child("Answers").max_value / Global.questions.size()) * max_size, 0, max_size), 30)

func _on_distribution_resized() -> void:
	update_answers_size()
