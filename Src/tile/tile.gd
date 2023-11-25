class_name tile extends Node2D

var hp : int = 100
var buildState : eBuildState = eBuildState.none
var collider = null
var hovered = false


func _ready():
	var anim = $AnimatedSprite2D
	anim.play()

func _on_area_2d_area_entered(area):
	if area.owner.get_class() == "tsunami":
		pass
		
func _on_area_2d_mouse_entered():
	var rect = $ColorRect
	hovered = true
	rect.visible = true

func _on_area_2d_mouse_exited():
	var rect = $ColorRect
	hovered = false
	rect.visible = false

func _input(event):
	if hovered:
		if Input.is_action_just_pressed("test"):
			pass

func isWater():
	if buildState == eBuildState.dead:
		return true
	else:
		return false

func erode(delta):
	hp = hp-1
	checkDead()

func checkDead():
	if hp <=0:
		buildState = eBuildState.dead
		$ColorRect.visible=true


enum eBuildState{
	none,
	dead,
	windmill
}




