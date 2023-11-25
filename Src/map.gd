class_name map extends Node

var GRID_HORIZ_SIZE : int = 31
var GRID_VERT_SIZE : int = 17
var TILE_HORIZ_SIZE : int = 64
var TILE_VERT_SIZE : int = 64
var rng = RandomNumberGenerator.new()
var min_health = 10
var max_health = 100
var grid = []
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in GRID_HORIZ_SIZE:
		grid.append([])
		for j in GRID_VERT_SIZE:
			var t = preload("res://Src/tile/tile.tscn").instantiate()
			t.transform = Transform2D(0.0,Vector2(i*TILE_HORIZ_SIZE,j*TILE_VERT_SIZE))
			t.hp = rng.randi_range(min_health,max_health)
			add_child(t)
			grid[i].append(t)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for i in GRID_HORIZ_SIZE:
		for j in GRID_VERT_SIZE:
			var x =grid[i][j]
			var a = clamp(i+1,0,GRID_HORIZ_SIZE-1)
			var b = clamp(i-1,0,GRID_HORIZ_SIZE-1)
			var c = clamp(j+1,0,GRID_VERT_SIZE-1)
			var d = clamp(j-1,0,GRID_VERT_SIZE-1)
			if grid[a][j].isWater() or grid[b][j].isWater() or grid[i][c].isWater() or grid[i][d].isWater():
				x.erode(delta)
