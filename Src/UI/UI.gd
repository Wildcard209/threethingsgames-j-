class_name HUD extends Node

var label
var label2
var string : String
var buns : String
# Called when the node enters the scene tree for the first time.
func _ready():
	label = $Label
	label2= $Label2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	label.text = "WIND: "+string
	label2.text = "BUNNIES: "+buns


func _on_button_pressed():
	get_tree().change_scene_to_file("res://Src/MainMenu.tscn")
