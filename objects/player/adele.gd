extends CharacterBody2D

class_name Player

const MAX_SPEED = 16;
const DAMAGE_TIME = 30.0;
const SHOOT_COOLDOWN_TIME = 15.0;
const DAMAGE_COOLDOWN_TIME = 120.0;

var state: PlayerState;

var speed: float;
var direction: Vector2;
var HP: int = 3;
var constantCounter: int = 0;
var invincible = false;

var delta: float;
var sprite: AnimatedSprite2D;


var shootingCooldown = 0.0;

const TEST_TUBE_PATH = "res://objects/projectiles/test_tube_bullet.tscn";

var takingDamage: bool = false;
var damageCounter: float = 0.0;
var damageCooldownTimer: float = 0.0;

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
	state.process(d);

func check_inputs():
	state.check_inputs();


func move():
	velocity = direction * speed * delta * Global.FPS_CAP;
	move_and_slide();


func shoot():
	if shootingCooldown <= 0.0:
			shootingCooldown = SHOOT_COOLDOWN_TIME;
			var tubeInstance : Bullet = Utils.createObject(TEST_TUBE_PATH,position + Vector2(160.0,0.0));
			tubeInstance.setSpeed(15.0);
			tubeInstance.setAcceleration(1.5);
			tubeInstance.setMaxSpeed(35.0);
			tubeInstance.setDirection(Vector2(1.0,0.0));
			
			get_tree().root.add_child(tubeInstance);
			changeSpriteFrame("shooting")
			

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
