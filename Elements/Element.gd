var isAlreadyCollided = false

func _ready():
	pass
	
func _action():
	if(!isAlreadyCollided):
		isAlreadyCollided = true
		self.hide()

func resetCollider():
	isAlreadyCollided = false