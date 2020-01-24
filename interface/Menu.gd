extends Control

var _player_name = ""
const numpad_resource = preload("res://interface/Numpad.tscn")
const keyboard_resource = preload("res://interface/Keyboard.tscn")

func _ready():
	get_node("VBoxContainer/server_container/TextField").text = Network.SERVER_IP

func _on_TextField_text_changed(new_text):
	_player_name = new_text

func _on_TextField2_text_changed(new_text):
	Network.SERVER_IP = new_text

func _on_CreateButton_pressed():
	if self.has_node("numpad") :
		get_node("numpad").queue_free()
	if self.has_node("keyboard") :
		get_node("keyboard").queue_free()
	_player_name = get_node("VBoxContainer/name_container/TextField").text
	Network.SERVER_IP = get_node("VBoxContainer/server_container/TextField").text
	if _player_name == "":
		return
	Network.create_server(_player_name)
	_load_game()

func _on_JoinButton_pressed():
	if self.has_node("numpad") :
		get_node("numpad").queue_free()
	if self.has_node("keyboard") :
		get_node("keyboard").queue_free()
	_player_name = get_node("VBoxContainer/name_container/TextField").text
	Network.SERVER_IP = get_node("VBoxContainer/server_container/TextField").text
	if _player_name == "":
		return
	Network.connect_to_server(_player_name)
	_load_game()

func _load_game():
	print(Network.SERVER_IP)
	get_tree().change_scene('res://Game.tscn')


func _on_name_field_focus_entered():
	if self.has_node("numpad") :
		get_node("numpad").queue_free()
	if self.has_node("keyboard") :
		return
	var keyboard_instance = keyboard_resource.instance()
	keyboard_instance.name = "keyboard"
	keyboard_instance.textbox = get_node("VBoxContainer/name_container/TextField")
	#get_node("VBoxContainer/name_container/TextField").set_focus_mode(0)
	self.add_child(keyboard_instance)

func _on_server_field_focus_entered():
	if self.has_node("keyboard") :
		get_node("keyboard").queue_free()
	if self.has_node("numpad") :
		return
	var numberpad_instance = numpad_resource.instance()
	numberpad_instance.name = "numpad"
	numberpad_instance.textbox = get_node("VBoxContainer/server_container/TextField")
	#get_node("VBoxContainer/name_container/TextField").set_focus_mode(0)
	self.add_child(numberpad_instance)
