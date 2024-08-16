extends Control

@export var eval: PackedScene

var questions = [
	{
		"time": 5,
		"question": "What is 2 + 2?",
		0: "3",
		1: "0",
		2: "8",
		3: "4",
		"answer": 3
	},
	{
		"time": 5,
		"question": "What's the capital of the United Kingdom",
		0: "London",
		1: "Washington D.C.",
		2: "Hogwarts",
		3: "Bangladesh",
		"answer": 0
	}
]
var current_question: int = 0
var selected_responses: Array[int] = []
var selected_response: int = -1

var timer: SceneTreeTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	questions = Global.questions
	
	timer = get_tree().create_timer(questions[current_question]["time"])
	timer.connect("timeout", no_click)
	%Timer.max_value = questions[0]["time"] * 100
	%Question.text = questions[0]["question"]
	%OptionA.text = questions[0][0]
	%OptionB.text = questions[0][1]
	%OptionC.text = questions[0][2]
	%OptionD.text = questions[0][3]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	%Timer.value = timer.time_left * 100

func finish():
	Global.responses = selected_responses
	
	get_tree().change_scene_to_packed(eval)

func no_click() -> void:
	next_question()

func next_question() -> void:
	selected_responses.append(selected_response)
	current_question += 1
	
	if current_question >= questions.size():
		finish()
		return
		
	if timer:
		timer.disconnect("timeout", no_click)
	timer = get_tree().create_timer(questions[current_question]["time"])
	timer.connect("timeout", no_click)
	
	%Timer.max_value = questions[current_question]["time"] * 100
	%Question.text = questions[current_question]["question"]
	%OptionA.text = questions[current_question][0]
	%OptionB.text = questions[current_question][1]
	%OptionC.text = questions[current_question][2]
	%OptionD.text = questions[current_question][3]
	
	selected_response = -1

func _on_option_a_pressed() -> void:
	selected_response = 0
	next_question()

func _on_option_b_pressed() -> void:
	selected_response = 1
	next_question()


func _on_option_c_pressed() -> void:
	selected_response = 2
	next_question()


func _on_option_d_pressed() -> void:
	selected_response = 3
	next_question()
