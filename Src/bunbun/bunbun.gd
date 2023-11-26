extends CharacterBody2D
# Get the gravity from the project settings to be synced with RigidBody nodes

var speed = 20
func _physics_process(delta):
	# Add the gravity.
	var direction = -get_local_mouse_position()
	position += delta*speed*direction
	pass
	# Handle Jump.
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
