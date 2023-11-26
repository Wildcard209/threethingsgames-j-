class_name bunbun extends CharacterBody2D
# Get the gravity from the project settings to be synced with RigidBody nodes

var speed = 10

func _ready():
	$AnimatedSprite2D.play()

func _physics_process(delta):
	#look_at(get_global_mouse_position())
	# Add the gravity.
	var direction = -position.direction_to(get_global_mouse_position())
	var multi = position.distance_to(get_global_mouse_position())
	print(multi)
	velocity = speed *direction*100/multi
	move_and_slide()
	# Handle Jump.
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.



func _on_area_2d_body_entered(body):
	if body as bunbun:
		var f = load("res://Src/bunbun/bunbun.tscn")
		add_sibling(f)
