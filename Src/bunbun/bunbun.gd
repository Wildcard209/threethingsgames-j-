class_name bunbun extends CharacterBody2D
# Get the gravity from the project settings to be synced with RigidBody nodes

var speed = 10
var Owner

func _ready():
	$AnimatedSprite2D.play()

func _physics_process(delta):
	#look_at(get_global_mouse_position())
	# Add the gravity.
	var direction = -position.direction_to(get_global_mouse_position())
	var multi = position.distance_to(get_global_mouse_position())
	velocity = speed *direction*100/multi
	move_and_slide()
	# Handle Jump.
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.

func breed(t):
	var f = load("res://Src/bunbun/bunbun.tscn").instantiate()
	f.position = position + Vector2(10,10)
	f.Owner = Owner
	f.Owner.buncount +=1
	Owner.add_child(f)

func _on_area_2d_body_entered(body):
	if body as bunbun:
		var f = load("res://Src/bunbun/bunbun.tscn")
		add_sibling(f)
