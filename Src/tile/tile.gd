class_name tile extends Node2D

var hp : int = 0
var collider = null


func _ready():
	collider = $Area2D
	




func _on_area_2d_area_entered(area):
	if area.owner == tsunami:
		pass
