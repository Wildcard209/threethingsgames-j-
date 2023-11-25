class_name tsunami extends CharacterBody2D

var damage = 5
var lifetime = 30
# Called when the node enters the scene tree for the first time.
func _ready():
	
	velocity.x = 10
	velocity.y = 10


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	lifetime-= delta
	if lifetime <0:
		queue_free()

func _physics_process(delta):
	move_and_slide()
