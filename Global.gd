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

var respawnTimer = -100;
const RESPAWN_TIME = 60 * 3;

var railObject: Node2D;

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

func _process(delta):
	var d = delta * Global.FPS_CAP;
	if respawnTimer != -100:
		respawnTimer -= d;
		if respawnTimer <= 0:
			respawnPlayer();
			respawnTimer = -100;

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
	var player = createObject(railObject,"res://objects/adele.tscn",Vector2(278,517));
	Global.PlayerHP = PLAYER_HP_MAX;
	player.damageCooldownTimer = player.DAMAGE_COOLDOWN_TIME;
	pass

func startRespawnTimer():
	respawnTimer = RESPAWN_TIME;
