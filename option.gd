extends PanelContainer

var selected: bool
var correct: bool
var option: String

func update() -> void:
	$Margin/Sorting/Option.text = option
	
	if correct:
		$Margin/Sorting/Correct.text = "✓"
		$Margin/Sorting/Correct.add_theme_color_override("font_color", Color(0, 1, 0))
	else:
		$Margin/Sorting/Correct.text = "x"
		$Margin/Sorting/Correct.add_theme_color_override("font_color", Color(1, 0, 0))
	
	var panel = StyleBoxFlat.new()
	panel.draw_center = true
	panel.bg_color = Color(0.2, 0.24, 0.29)
	panel.border_color = Color(0, 0.9, 1)
	panel.set_corner_radius_all(5)
	if selected:
		panel.set_border_width_all(2)
	add_theme_stylebox_override("panel", panel)
	
