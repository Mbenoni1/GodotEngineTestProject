#handling press events

var menuNode
var quitNode

func _ready():
	menuNode = get_node("../../MainMenuPanel")
	quitNode = get_node("../../QuitMenuPanel")
	quitNode.hide()
	menuNode.show()

func _on_Career_pressed():
	get_tree().change_scene("res://main.tscn")

func _on_Quit_pressed():
	menuNode.hide()
	quitNode.show()

func _on_Yes_pressed():
	get_tree().quit()

func _on_No_pressed():
	quitNode.hide()
	menuNode.show()
