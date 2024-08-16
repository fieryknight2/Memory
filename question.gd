extends PanelContainer

var question
var response

func _ready() -> void:
	$MarginContainer/Selected/Question.text = question["question"]
	
	if question["answer"] == response:
		$MarginContainer/Selected/Correct.text = "✓"
		$MarginContainer/Selected/Correct.add_theme_color_override("font_color", Color(0, 1, 0))
	else:
		$MarginContainer/Selected/Correct.text = "x"
		$MarginContainer/Selected/Correct.add_theme_color_override("font_color", Color(1, 0, 0))

	$MarginContainer/Selected/Options/A.selected = (response == 0)
	$MarginContainer/Selected/Options/A.correct = question["answer"] == 0
	$MarginContainer/Selected/Options/A.option = question[0]
	$MarginContainer/Selected/Options/A.update()
	
	$MarginContainer/Selected/Options/B.selected = (response == 1)
	$MarginContainer/Selected/Options/B.correct = question["answer"] == 1
	$MarginContainer/Selected/Options/B.option = question[1]
	$MarginContainer/Selected/Options/B.update()
	
	$MarginContainer/Selected/Options/C.selected = (response == 2)
	$MarginContainer/Selected/Options/C.correct = question["answer"] == 2
	$MarginContainer/Selected/Options/C.option = question[2]
	$MarginContainer/Selected/Options/C.update()
	
	$MarginContainer/Selected/Options/D.selected = (response == 3)
	$MarginContainer/Selected/Options/D.correct = question["answer"] == 3
	$MarginContainer/Selected/Options/D.option = question[3]
	$MarginContainer/Selected/Options/D.update()
