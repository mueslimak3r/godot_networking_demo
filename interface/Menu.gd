extends Control

var _player_name = ""
const numpad_resource = preload("res://interface/Numpad.tscn")

func _ready():
	get_node("VBoxContainer/server_container/TextField").text = Network.SERVER_IP

func _on_TextField_text_changed(new_text):
	_player_name = new_text

func _on_TextField2_text_changed(new_text):
	Network.SERVER_IP = new_text

func _on_CreateButton_pressed():
	if self.has_node("numpad") :
		get_node("numpad").queue_free()
	if _player_name == "":
		return
	Network.create_server(_player_name)
	_load_game()

func _on_JoinButton_pressed():
	if self.has_node("numpad") :
		get_node("numpad").queue_free()
	if _player_name == "":
		return
	Network.connect_to_server(_player_name)
	_load_game()

func _load_game():
	print(Network.SERVER_IP)
	#get_tree().change_scene('res://Game.tscn')


func _on_name_field_focus_entered():
	if self.has_node("numpad") :
		get_node("numpad").queue_free()


func _on_server_field_focus_entered():
	var numberpad_instance = numpad_resource.instance()
	numberpad_instance.name = "numpad"
	numberpad_instance.textbox = get_node("VBoxContainer/server_container/TextField")
	#get_node("VBoxContainer/name_container/TextField").set_focus_mode(0)
	self.add_child(numberpad_instance)
