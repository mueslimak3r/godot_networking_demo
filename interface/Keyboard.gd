extends Control

var textbox

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_input(input) :
	textbox.append_at_cursor(input)

func _on_clear_pressed():
	textbox.clear()
