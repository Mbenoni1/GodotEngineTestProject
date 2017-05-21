
func _ready():
	var t = Theme.new()
	t.set_color("background_color","Control",Color(1.0,1.0,1.0))
	self.set_theme(t)