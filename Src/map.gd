class_name map extends Node

var GRID_HORIZ_SIZE : int = 30
var GRID_VERT_SIZE : int = 30
var layers = {}
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in eLayers:
		layers[i] = []
	for i in range(GRID_VERT_SIZE):
		layers[eLayers.Base].append([])
		for j in range(GRID_HORIZ_SIZE):
			layers[eLayers.Base][j].append(tile.new())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

enum eLayers{
	Base,
	Island,
	Cosmetic,
	Building,
	Entity,
	Weather
}
