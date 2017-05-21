

func _ready():
	#set_process(true)
	print("ready ? GO !")
	

func _process(delta):
	var selectedButtonIndex = get_selected()
	if(selectedButtonIndex == 0): #
		print("0")
	elif(selectedButtonIndex == 1): #
		print("1")
	elif(selectedButtonIndex == 2): #
		print("2")
	elif(selectedButtonIndex == 3): #
		print("3")
	elif(selectedButtonIndex == 4): #
		print("4")
	
	