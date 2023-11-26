extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	#$AudioStreamPlayer2D.play("res://Src/Panga Panda.wav")
	#$AudioStreamPlayer2D.autoplay()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Main.tscn")


func _on_button_2_pressed():
	get_tree().quit()


func _on_audio_stream_player_2d_finished():
	$AudioStreamPlayer2D.play()
