extends KinematicBody2D

export var gravity = 10
export var jump_force = 256
export var speed = 100

onready var animation_tree = $AnimationTree

var velocity : Vector2

func _physics_process(_delta):	
	var input = Input.get_action_strength("right") - Input.get_action_strength("left")
	$Sprite.scale.x = sign(input if input != 0 else $Sprite.scale.x)
	
	velocity.x = input * speed
	velocity.y += gravity
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	if is_on_floor():
		animation_tree["parameters/AirState/current"] = 0
		if velocity.length() < 10:
			animation_tree["parameters/GroundState/current"] = 0
		else:
			animation_tree["parameters/GroundState/current"] = 1
		
		if Input.is_action_just_pressed("jump"):
			velocity.y = -jump_force
	else:
		animation_tree["parameters/AirState/current"] = 1
