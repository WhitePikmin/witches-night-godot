extends AudioStreamPlayer

var music

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func stopMusic():
	stop()
	
func setMusicPath(path: String):
	stop()
	music = load(path) as AudioStreamMP3
	music.loop = true
	
	stream = music
	
func playMusic():
	play()
