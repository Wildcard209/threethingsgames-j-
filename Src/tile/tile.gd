class_name tile extends Node2D

var max_hp :int = 100
var hp : int = 100
var buildState : eBuildState = eBuildState.none
var hovered = false


func _ready():
	var anim = $AnimatedSprite2D
	hp = max_hp
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
			hp = 500
			buildState = eBuildState.none
			changeAnimState()

func isWater():
	if buildState == eBuildState.dead:
		return true
	else:
		return false

func erode(water,delta):
	hp = hp-water
	checkDead()
	changeAnimState()

func checkDead():
	if hp <=0:
		buildState = eBuildState.dead

func changeAnimState():
	if buildState == eBuildState.dead:
		$Sprite2D.visible=false
		$Sprite2D2.visible=false
	if buildState == eBuildState.none:
		$Sprite2D.visible = true

enum eBuildState{
	none,
	dead,
	windmill
}
