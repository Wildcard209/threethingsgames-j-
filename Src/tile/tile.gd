class_name tile extends Node2D

var hp : int = 100
var buildState : eBuildState = eBuildState.none
var collider = null


func _ready():
	pass

func _on_area_2d_area_entered(area):
	if area.owner == tsunami:
		pass

enum eBuildState{
	none,
	windmill
}
