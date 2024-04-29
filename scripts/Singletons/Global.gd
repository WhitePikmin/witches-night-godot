@tool
extends Node

signal star_count_changed

const FPS_CAP = 60;
const SCREEN_SCROLL_SPEED = 2;

var current_scene = null

var Player: CharacterBody2D;

var PlayerHP: int;
const PLAYER_HP_MAX = 3;

var Lives: int;
const LIVES_STARTING_COUNT = 3;

var respawnTimer = -100;
const RESPAWN_TIME = 60 * 3;

var consoleObject: CanvasLayer;


var consoleHistory: Array = [];

var collectedStarTarget: Vector2 = Vector2(0,0);
var starDisplay: Node2D;
var root: Node;
@export var starCount: int:

	set(val):
		starCount = val;
		emit_signal("star_count_changed");


func _ready():
	root = get_tree().get_root();
	process_mode = Node.PROCESS_MODE_ALWAYS;
	starCount = 0;
	PlayerHP = PLAYER_HP_MAX;
	Lives = LIVES_STARTING_COUNT;
	current_scene = root.get_child(root.get_child_count() -1);

func _process(delta):
	if ! Engine.is_editor_hint():
		var d = delta * Global.FPS_CAP;
		if respawnTimer != -100:
			respawnTimer -= d;
			if respawnTimer <= 0:
				respawnPlayer();
				respawnTimer = -100;
	
		if Input.is_action_just_pressed("debug_console"):
			if ! get_tree().paused:
				get_tree().paused = true;
				var c = Utils.loadAsset("res://misc/debug_console.tscn");
				consoleObject = c.instantiate();
				get_tree().root.add_child(consoleObject);
			else:
				consoleHistory.pop_back();
				endConsole();

func respawnPlayer():
	var player = Utils.createObject("res://objects/player/adele.tscn",Vector2(278,517));
	Global.PlayerHP = PLAYER_HP_MAX;
	player.damageCooldownTimer = player.DAMAGE_COOLDOWN_TIME;
	pass

func startRespawnTimer():
	respawnTimer = RESPAWN_TIME;

func endConsole():
	get_tree().paused = false;
	if consoleObject != null:
		consoleObject.queue_free();
