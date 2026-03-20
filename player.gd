extends CharacterBody2D


const SPEED = 110.0
const JUMP_VELOCITY = -200.0
const JUMP_VELOCITY2 = -300.0
@onready var animated_sprite_2d_2 = $AnimatedSprite2D2
@onready var animated_sprite_2d = $AnimatedSprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var gravity = 300
var max_health = 3
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction (input_axis) and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_axis = Input.get_axis("ui_left", "ui_right")
	if input_axis:
		velocity.x = input_axis * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	update_animations(input_axis)


func update_animations(input_axis):
	if input_axis < 0:
		animated_sprite_2d.flip_h = true
	elif input_axis > 0:
		animated_sprite_2d.flip_h = false
	if is_on_floor():
		if input_axis != 0:
			animated_sprite_2d.play("skip")
		else:
			animated_sprite_2d.play("idle")
	else:
		animated_sprite_2d.play("jump")
		
		
		
		
func bounce():
	velocity.y = JUMP_VELOCITY2
	
func die():
	if max_health > 0:
		max_health-=1
		animated_sprite_2d.play("hurt")
	else:
		get_tree().reload_current_scene()
		pass

	if max_health > 2 and max_health < 4:
		animated_sprite_2d_2.play("default")
	if max_health > 1 and max_health < 3:
		animated_sprite_2d_2.play("new_animation")
	if max_health > 0 and max_health < 2:
		animated_sprite_2d_2.play("new_animation_1")
	if max_health > -1 and max_health < 1:
		animated_sprite_2d_2.play("new_animation_2")
		
func health():
	max_health + 1
