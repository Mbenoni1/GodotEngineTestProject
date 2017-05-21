extends Camera

var isAnimated = false
var anim
var isShaking = false
var duration = 0.0
var period_in_ms = 0.0
var amplitude = 0.0
var timer = 0.0
var last_shook_timer = 0
var previous_x = 0.0
var previous_y = 0.0
var last_offset = Vector2(0, 0)

func _ready():
	get_node("DepthEffect").hide()
	anim = get_node('AnimationDepth')
	set_fixed_process(true)
	
func _fixed_process(delta):
	if(!Global.isMovingY):
		isAnimated = false
		if(!Global.isTutorial):
			self.translate(Vector3(0, Global.SPEED*delta, 0))
	elif(!isAnimated):
		isAnimated = true
		if(Global.isUp):
			anim.play("DepthAnimationUp")
		else:
			anim.play("DepthAnimationDown")
	if timer == 0:
		return
	last_shook_timer = last_shook_timer + delta
	while last_shook_timer >= period_in_ms:
		last_shook_timer = last_shook_timer - period_in_ms
		var intensity = amplitude * (1 - ((duration - timer) / duration))
		var new_x = rand_range(-1.0, 1.0)
		var x_component = intensity * (previous_x + (delta * (new_x - previous_x)))
		var new_y = rand_range(-1.0, 1.0)
		var y_component = intensity * (previous_y + (delta * (new_y - previous_y)))
		previous_x = new_x
		previous_y = new_y
		var new_offset = Vector2(x_component, y_component)
		set_h_offset(get_h_offset() - last_offset.x + new_offset.x)
		set_v_offset(get_h_offset() - last_offset.y + new_offset.y)
		last_offset = new_offset
	timer = timer - delta
	if timer <= 0:
		timer = 0
		set_h_offset(get_h_offset() - last_offset.x)
		set_v_offset(get_v_offset() - last_offset.y)
		isShaking = false

func shake(p_duration, p_frequency, p_amplitude):
	if(!isShaking): 
		isShaking = true
		duration = p_duration
		timer = p_duration
		period_in_ms = 1.0 / p_frequency
		amplitude = p_amplitude
		previous_x = rand_range(-1.0, 1.0)
		previous_y = rand_range(-1.0, 1.0)
		set_h_offset(get_h_offset() - last_offset.x)
		set_v_offset(get_v_offset() - last_offset.y)
		last_offset = Vector2(0, 0)

func on_restart():
	get_node("DepthEffect").hide()
	set_h_offset(0)
	set_v_offset(0)
	isShaking = false
	var transformCamera = get_transform()
	global_translate(Vector3(0, 0, -transformCamera.origin.z - 400)) 