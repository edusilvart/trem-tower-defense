extends Car


func _physics_process(delta: float) -> void:
	var steer_power = -Input.get_action_strength('Steer_Left') + Input.get_action_strength('Steer_Right')
	steer(steer_power, delta)
	
	accelerate(Input.get_action_raw_strength("Accelerate"), delta)
	if Input.is_action_pressed('Brake'):
		stop(delta)
