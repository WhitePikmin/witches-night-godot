@tool
extends Node

signal star_count_changed

const FPS_CAP = 60;
const FRAME_DURATION = 1 / FPS_CAP;
const DELTA_LIMIT = FPS_CAP / 3;
const SCREEN_SCROLL_SPEED = 2;
const DRAMATIC_PAUSE_LENGTH = 100;

var current_scene = null

var Player: Player;
var Boss: Enemy;

var PlayerHP: int;
const PLAYER_HP_MAX = 3;

var Lives: int;
const LIVES_STARTING_COUNT = 3;

var respawnTimer = -100;
const RESPAWN_TIME = 60 * 3;

var consoleObject: CanvasLayer;
var moveBg = true;

var nextLevel : String = "res://rooms/room_test.tscn"

var dramaticPause = false;
var dramaticPauseTimer = 0;

var background: Background;


var consoleHistory: Array = [];

var collectedStarTarget: Vector2 = Vector2(0,0);
var starDisplay: Node2D;
var root: Node;
var transitionFade: TransitionFade;
@onready var HUD: CanvasLayer = $HUD;

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

func goto_next_level():
	if(transitionFade):
		transitionFade.fadeOut(nextLevel);

func _process(delta):
	if !dramaticPause:
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
			
			moveRails(delta);
	else:
		dramaticPauseTimer -= (delta * Global.FPS_CAP);
		if(dramaticPauseTimer <= 0):
			dramaticPause = false;
			background.setFadeEffect(false);
			get_tree().paused = false;
			Boss.explode();
			Utils.destroyAllEnemies();
			Boss = null;

func moveRails(d):
	if (Utils.railObject != null):
		var delta = Global.FPS_CAP * d;
		var deltaX = SCREEN_SCROLL_SPEED * delta;
		if (moveBg):
			Utils.railObject.position.x += deltaX;
		else :
			background.moveBg(Vector2(-deltaX,0.0));

func respawnPlayer():
	var player = Utils.createObject("res://objects/player/adele.tscn",Vector2(278,517));
	Global.PlayerHP = PLAYER_HP_MAX;
	player.changeState(PlayerState_Grace.new());
	player.damageGraceTimer.start();
	pass

func startRespawnTimer():
	respawnTimer = RESPAWN_TIME;

func endConsole():
	get_tree().paused = false;
	if consoleObject != null:
		consoleObject.queue_free();

func startCustcene(HudLayer:CanvasLayer):
	var obj = preload("res://cutscene/cutscene_layer.tscn");
	var instance = obj.instantiate();
	get_tree().root.add_child(instance);
	HUD.visible = false;
	moveBg = false;
	

func endCutscene():
	Global.Player.changeState(PlayerState_Normal.new());
	if(Global.Boss != null):
		Global.Boss.startHostility();
	HUD.visible = true;

func killBoss():
	if !dramaticPause and Boss != null :
		background.setFadeEffect(true);
		get_tree().paused = true;
		dramaticPause = true;
		dramaticPauseTimer = DRAMATIC_PAUSE_LENGTH;
		
		var snd : Node = Utils.createObject("res://sounds/SoundEmitter.tscn",Boss.position);
		snd.stream = load("res://sounds/assets/sfx/snd_crash.wav");
		snd.process_mode = Node.PROCESS_MODE_ALWAYS;
		snd.play();
		

func adjustDelta(delta:float):
	if delta > DELTA_LIMIT:
		return FRAME_DURATION;
	return delta;
