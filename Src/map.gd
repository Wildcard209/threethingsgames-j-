class_name map extends Node

var GRID_HORIZ_SIZE : int = 2
var GRID_VERT_SIZE : int = 5
var TILE_HORIZ_SIZE : int = 64
var TILE_VERT_SIZE : int = 64
var layers = []
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in eLayers:
		layers.append([])
	for i in GRID_HORIZ_SIZE:
		layers[eLayers.Base].append([])
		for j in GRID_VERT_SIZE:
			var t = preload("res://Src/tile/tile.tscn").instantiate()
			t.transform = Transform2D(0.0,Vector2(i*TILE_HORIZ_SIZE,j*TILE_VERT_SIZE))
			add_child(t)
			layers[eLayers.Base][i].append(t)


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
