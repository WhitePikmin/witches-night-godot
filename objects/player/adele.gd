extends CharacterBody2D

class_name Player

const MAX_SPEED = 16;
const FOCUS_SPEED = 6;

var state: PlayerState;

var speed: float;
var direction: Vector2;
var HP: int = 3;
var constantCounter: int = 0;
var invincible = false;

var delta: float;
var sprite: AnimatedSprite2D;

var focusing : bool = false;


var shootingCooldown: bool = true;

@onready var shootCooldownTimer: Timer = $ShootCooldown_timer;
@onready var damageGraceTimer: Timer = $DamageGrace_timer;
@onready var damagedTimer : Timer = $Damaged_timer;

@onready var hitboxSprite : Sprite2D = $hitboxSprite;

@onready var HUDLayer = $HUD;

const TEST_TUBE_PATH = "res://objects/projectiles/test_tube_bullet.tscn";

var spriteOffsets = {
	"default": Vector2(0,0),
	"hurt":    Vector2(0,0),
	"shooting":Vector2(3,-0.5)
};

# Called when the node enters the scene tree for the first time.
func _ready():
	state = PlayerState_Normal.new();
	state.setup(self);
	add_child(state);

	speed = 0;
	direction = Vector2(0,0);
	velocity = Vector2(0,0);
	delta = 1.0/Global.FPS_CAP;
	sprite = $AnimatedSprite2D;
	
	changeSpriteFrame("default")
	
	Global.Player = self;
	
	pass # Replace with function body.


func changeState(newState: PlayerState):
	remove_child(state);
	state.queue_free();
	newState.setup(self);
	state = newState;
	add_child(state);

# Called every frame. 'd' is the elapsed time since the previous frame.
func _process(d):
	state.process(Global.adjustDelta(d));

func check_inputs():
	state.check_inputs();

func move():
	velocity = direction * speed * delta * Global.FPS_CAP;
	move_and_slide();

func shoot():
	state.shoot();

func takeAHit(hpLoss: int):
	state.takeAHit(hpLoss);

func die():
	Global.PlayerHP = 0;
	Global.Lives -= 1;
	Utils.createObject("res://objects/particles/poofCloud.tscn",position);
	Global.startRespawnTimer();
	Utils.playSound("res://sounds/assets/sfx/snd_death.wav",position);
	queue_free();

func changeSpriteFrame(name: String):
	sprite.play(name,1.0,false)
	sprite.offset = spriteOffsets[name];
	pass

func collect():
	pass

func startCutscene():
	state.startCutscene();

func shotCoolDown():
	state.shotCoolDown();

func unDamage():
	state.unDamage();

func removeGracePeriod():
	state.removeGracePeriod();
