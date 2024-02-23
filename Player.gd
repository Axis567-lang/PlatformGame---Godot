extends KinematicBody2D

export(int) var JUMP_FORCE = -130
	# a variable that can be modified on the inspector menu
#const JUMP_FORCE = -130

var velocity = Vector2.ZERO

func _physics_process(delta):
	apply_gravity()
	
	var input = Vector2.ZERO
	input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	if input.x == 0:
		apply_friction()
	else:
		apply_acceleration(input.x)
	
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			velocity.y = JUMP_FORCE
	else:
		if Input.is_action_just_released("ui_up") and velocity.y < -70:
			velocity.y = -70
		
		if velocity.y > 0:
			velocity.y += 2
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
func apply_gravity():
	velocity.y += 6

func apply_friction():
	velocity.x = move_toward(velocity.x, 0, 5)

func apply_acceleration(amount):
	velocity.x = move_toward(velocity.x, 50 * amount, 15)

	
