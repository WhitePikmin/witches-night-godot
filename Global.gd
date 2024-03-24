@tool
extends Node

signal star_count_changed

const FPS_CAP = 60;
const SCREEN_SCROLL_SPEED = 2;

var current_scene = null

var loadedAssets = {};
var Player: CharacterBody2D;

var PlayerHP: int;
const PLAYER_HP_MAX = 3;

var Lives: int;
const LIVES_STARTING_COUNT = 3;

@export var starCount: int:
	set(val):
		starCount = val;
		emit_signal("star_count_changed");


func _ready():
	var root = get_tree().get_root();
	starCount = 0;
	PlayerHP = PLAYER_HP_MAX;
	Lives = LIVES_STARTING_COUNT;
	current_scene = root.get_child(root.get_child_count() -1);

func createObject(root: Node,path: String,pos: Vector2):
	var obj = loadAsset(path);
	var instance = obj.instantiate();
	instance.position = pos;
	root.add_child(instance);
	return instance;


func playSound(root: Node,soundPath: String,pos: Vector2):
	var snd = createObject(root,"res://sounds/SoundEmitter.tscn",pos);
	snd.stream = loadAsset(soundPath);
	snd.play();
	return snd;

func loadAsset(path: String):
	if !loadedAssets.has(path):
		loadedAssets[path] = load(path);
	
	return loadedAssets[path];

func respawnPlayer():
	pass


