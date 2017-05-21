extends Panel

var style = StyleBoxFlat.new()

#func _ready():
#	set_process(true)
#	var projectResolution=Vector2(Globals.get("display/width"),Globals.get("display/height"))
#	self.set_size(projectResolution*2)
#	# The Panel doc tells you which style names there are
#	add_style_override("panel", style)
#	var color
#	if(self.get_name() == "BannerPanel"):
#		color = Color(0.63, 0, 0, 0.5)
#	else:
#		color = Color(0.63, 0, 0, 0.5)
#	style.set_bg_color(color)
#	# update so the control will redraw
#	update()

func _process(delta):
	var projectResolution=Vector2(2*Globals.get("display/width"),0.43*Globals.get("display/height"))
	self.set_size(projectResolution)