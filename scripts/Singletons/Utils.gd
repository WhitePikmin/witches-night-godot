@tool
extends Node

enum CreateAt {
	ROOT,
	RAIL
}

var loadedAssets = {};
var railObject: Node2D;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func createObject(path: String,pos: Vector2, where: CreateAt = CreateAt.RAIL):
	var obj = loadAsset(path);
	var instance = obj.instantiate();
	instance.position = pos;
	
	if where == CreateAt.RAIL:
		if railObject != null:
			railObject.add_child(instance);
		else:
			get_tree().root.add_child(instance);
	elif where == CreateAt.ROOT:
		get_tree().root.add_child(instance);
		
	return instance;


func playSound(soundPath: String,pos: Vector2):
	var snd = createObject("res://sounds/SoundEmitter.tscn",pos + railObject.position,CreateAt.ROOT);
	snd.stream = loadAsset(soundPath);
	snd.play();
	return snd;

func loadAsset(path: String):
	if !loadedAssets.has(path):
		loadedAssets[path] = load(path);
	
	return loadedAssets[path];
