class_name tsunami extends CharacterBody2D
var lifetime = 250
var speed = 2000
var damage = 5
# Called when the node enters the scene tree for the first time.
func _ready():
	velocity.x = 80
	velocity.y = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	lifetime-= delta
	if lifetime <0:
		queue_free()

func _physics_process(delta):
	move_and_slide()
