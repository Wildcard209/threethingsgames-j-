class_name map extends Node

var GRID_HORIZ_SIZE : int = 32
var GRID_VERT_SIZE : int = 18
var TILE_HORIZ_SIZE : int = 64
var TILE_VERT_SIZE : int = 64
var rng = RandomNumberGenerator.new()
var min_health = 5
var max_health = 60
var grid = []

var UI
var buncount = 0

var wind : int = 50

var TIMER_MAX :int = 3
var timer

var MIN_TSUNAMI_TIMER = 25
var MAX_TSUNAMI_TIMER = 150
var tsunamiMaxTimer = rng.randi_range(MIN_TSUNAMI_TIMER,MAX_TSUNAMI_TIMER)
var tsunamiTimer = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	UI = $map/UI as HUD
	timer = TIMER_MAX
	tsunamiTimer=tsunamiMaxTimer
	for i in GRID_HORIZ_SIZE:
		grid.append([])
		for j in GRID_VERT_SIZE:
			var t = preload("res://Src/tile/tile.tscn").instantiate()
			t.transform = Transform2D(0.0,Vector2(i*TILE_HORIZ_SIZE,j*TILE_VERT_SIZE))
			t.max_hp = rng.randi_range(min_health,max_health)
			t.Owner = self
			t.x = i
			t.y = j
			add_child(t)
			grid[i].append(t)
	for i in range(5,16):
		for j in range(3,9):
			grid[i][j].buildState = tile.eBuildState.none
	
	var f = load("res://Src/bunbun/bunbun.tscn").instantiate()
	f.position = grid[8][7].position
	f.Owner = self
	add_child(f)
	f = load("res://Src/bunbun/bunbun.tscn").instantiate()
	f.position = grid[10][5].position
	f.Owner = self
	add_child(f)
	f = load("res://Src/bunbun/bunbun.tscn").instantiate()
	f.position = grid[9][4].position
	f.Owner = self
	add_child(f)
	buncount = 3
func spawnTsunami():
	var x = load("res://Src/Tsunami/Tsunami.tscn").instantiate()
	x.transform = Transform2D(0.0,Vector2(3,24),0,Vector2(-100,-100))
	add_child(x)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer = timer - delta
	tsunamiTimer = tsunamiTimer - delta
	UI.string = str(wind)
	UI.buns = str(buncount)
	if timer <= 0:
		timer = TIMER_MAX/(log(buncount)/3)
		for i in GRID_HORIZ_SIZE:
			for j in GRID_VERT_SIZE:
				var x =grid[i][j] as tile
				if x.buildState != tile.eBuildState.dead:
					var water = findSurroundingWater(i,j)
					if  water>0:
						x.erode(water,delta)
	var allWater = true
	for i in GRID_HORIZ_SIZE:
			for j in GRID_VERT_SIZE:
				if grid[i][j].isGround():
					allWater = false
	if allWater:
		endGame()
	var buns = 0
	for i in get_children():
		if i as bunbun:
			buns +=1
	if buns ==0:
		print("boop")
		UI.bundead()
	if tsunamiTimer < 0:
		tsunamiTimer = tsunamiMaxTimer
		spawnTsunami()
		

func endGame():
	print("end")
	UI.bundead()

func findSurroundingWater(x,y):
	var a = clamp(x+1,0,GRID_HORIZ_SIZE-1)
	var b = clamp(x-1,0,GRID_HORIZ_SIZE-1)
	var c = clamp(y+1,0,GRID_VERT_SIZE-1)
	var d = clamp(y-1,0,GRID_VERT_SIZE-1)
	var out = 0
	if grid[a][y].isWater():
		out+=1
	if grid[b][y].isWater():
		out +=1
	if grid[x][c].isWater():
		out+=1
	if grid[x][d].isWater():
		out+=1
	return out
