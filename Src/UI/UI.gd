class_name HUD extends Node

var label
var string : String

# Called when the node enters the scene tree for the first time.
func _ready():
	label = $Label


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	label.text = "WIND: "+string
