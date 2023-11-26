class_name tile extends Node2D

var max_hp :int = 100
var hp : int = 100
var buildState : eBuildState = eBuildState.dead
var hovered = false
var Owner
var x :int
var y :int
var grassno = str(randi_range(1,13))

var Rect

var buildingHP:int = 5
var buildingHPMax :int = 5
var productionTimeMax = 0.7
var prodTime = productionTimeMax

var bunTimeMax = 5
var bunTime = productionTimeMax

var windmillCost = 50
var groundCost = 20

var buns = []

func _ready():
	var anim = $AnimatedSprite2D
	Rect = $ColorRect
	$Sprite2D2.play()
	
	hp = max_hp
	buildingHP = buildingHPMax
	anim.play()
	prodTime = productionTimeMax
	

func _process(delta):
	changeAnimState()
	if buildState ==  eBuildState.windmill:
		prodTime = prodTime - delta
		if prodTime <=0:
			produce()
			prodTime = productionTimeMax
	if buildState == eBuildState.none && buns.size() >=2:
		bunTime -= delta
		if bunTime <0:
			if is_instance_valid(buns[0]):
				buns[0].breed(self)
				bunTime = bunTimeMax

func produce():
	Owner.wind+=1

func _on_area_2d_area_entered(area):
	if  area.owner.get_class() == "CharacterBody2D":
		if area.owner as tsunami:
			if buildState == eBuildState.windmill:
				damageBuilding(area.owner.damage)
		elif area.owner as bunbun:
			if buildState == eBuildState.dead:
				area.owner.queue_free()
			else:
				buns.append(area.owner)
			
func damageBuilding(damage):
	buildingHP -= damage
	if buildingHP <=0:
		print("dead")
		buildState = eBuildState.none
		changeAnimState()

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
		if Input.is_action_just_pressed("test") && connectedToLand() && canBuild(groundCost,true) && !isGround():
			hp = max_hp
			buildState = eBuildState.none
			Owner.wind -= groundCost
			changeAnimState()
		if Input.is_action_just_pressed("build") && canBuild(windmillCost):
			buildingHP = buildingHPMax
			buildState = eBuildState.windmill
			Owner.wind -= windmillCost
			changeAnimState()

func canBuild(cost,ignoreLand = false):
	return (buildState != eBuildState.dead||ignoreLand) && buildState != eBuildState.windmill && Owner.wind >= cost

func connectedToLand():
	return Owner.findSurroundingWater(x,y) != 4

func isWater():
	if buildState == eBuildState.dead:
		return true
	else:
		return false

func isGround():
	if buildState != eBuildState.dead:
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
		for i in buns:
			i.queue_free()

func changeAnimState():
	match buildState:
		eBuildState.dead:
			$Sprite2D.visible=false
			$Sprite2D2.visible=false
		eBuildState.none:
			$Sprite2D.visible = true
			$Sprite2D2.visible=false
		eBuildState.windmill:
			$Sprite2D.visible = true
			$Sprite2D2.visible = true
	
	if isGround() && true:
		$Sprite2D.texture = load("res://Assets/Ground/"+getSurroundingTilesString()+".png")
	

func getSurroundingTilesString():
	var grid = [] + Owner.grid
	var out = ""
	if max_hp/hp > 2:
		out += "Grass_Eroded_Edge"
	else:
		out +="Grass_Edge"
	var e = clamp(x+1,0,Owner.GRID_HORIZ_SIZE-1)
	var w = clamp(x-1,0,Owner.GRID_HORIZ_SIZE-1)
	var s = clamp(y+1,0,Owner.GRID_VERT_SIZE-1)
	var n = clamp(y-1,0,Owner.GRID_VERT_SIZE-1)
		
	var north = grid[x][n].isWater()
	#grid[x][n].Rect.visible = true
	var west = grid[w][y].isWater()
	#grid[w][y].Rect.visible = true
	var east = grid[e][y].isWater()
	#grid[e][y].Rect.visible = true
	var south = grid[x][s].isWater()
	#grid[x][s].Rect.visible = true
		
	if grid[w][n].isWater() || north || west:
		out=out + "_NW"
		#grid[w][n].Rect.visible = true
	if north:
		out=out + "_N"
	if grid[e][n].isWater() || north || east:
		out=out + "_NE"
		#grid[e][n].Rect.visible = true
	if west:
		out=out + "_W"
	if east:
		out=out + "_E"
	if grid[w][s].isWater() || south || west:
		out=out + "_SW"
		#grid[w][s].Rect.visible = true
	if south:
		out=out + "_S"
	if grid[e][s].isWater() || east || south:
		out=out + "_SE"
		#grid[e][s].Rect.visible = true
	if out == "Grass_Edge":
		out = "Grass_Inside_"
		out = out+grassno
	elif out == "Grass_Eroded_Edge":
		out = "Grass_Eroded_1"
		
	return out
		
enum eBuildState{
	none,
	dead,
	windmill
}


func _on_area_2d_area_exited(area):
	if area.owner as bunbun:
		var bun = buns.find(area.owner)
		if bun != -1:
			buns.remove_at(bun)
