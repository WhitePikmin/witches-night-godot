extends CharacterBody2D

const MAX_SPEED = 16;
const DAMAGE_TIME = 30.0;
const SHOOT_COOLDOWN_TIME = 15.0;
const DAMAGE_COOLDOWN_TIME = 120.0;

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
	speed = 0;
	direction = Vector2(0,0);
	velocity = Vector2(0,0);
	delta = 1/Global.FPS_CAP;
	sprite = $AnimatedSprite2D;
	
	changeSpriteFrame("default")
	
	Global.Player = self;
	
	pass # Replace with function body.


# Called every frame. 'd' is the elapsed time since the previous frame.
func _process(d):
	delta = d * Global.FPS_CAP;
	clampf(delta,1.0,2.0);
	
	if shootingCooldown > 0.0:
		shootingCooldown -= delta;
		if shootingCooldown <= 0.0:
			changeSpriteFrame("default");
			
	if damageCooldownTimer > 0.0:
		sprite.visible = ((constantCounter / 3) % 2 == 0);
		damageCooldownTimer -= delta;
		if damageCooldownTimer <= 0.0:
			sprite.visible = true;
			
	if takingDamage:
		pass
		direction = Vector2(-0.5,0.5);
		speed = 12.0;
		damageCounter -= delta;
		if damageCounter <= 0.0:
			takingDamage = false;
			changeSpriteFrame("default");
			damageCooldownTimer = DAMAGE_COOLDOWN_TIME;
	else:
		check_inputs();
	
	move();
	
	constantCounter += 1;

func check_inputs():
	if Input.is_action_pressed("ui_left"):
		direction.x = -1;
	elif Input.is_action_pressed("ui_right"):
		direction.x = 1;
	else:
		direction.x = 0;

	if Input.is_action_pressed("ui_up"):
		direction.y = -1;
	elif Input.is_action_pressed("ui_down"):
		direction.y = 1;
	else:
		direction.y = 0;
	
	if Input.is_action_pressed("shoot"):
		shoot();
	
	if direction == Vector2(0,0):
		speed = 0;
	else:
		speed = MAX_SPEED;
		direction = direction.normalized();


func move():
	velocity = direction * speed * delta * Global.FPS_CAP;
	move_and_slide();


func shoot():
	if shootingCooldown <= 0.0:
			shootingCooldown = SHOOT_COOLDOWN_TIME;
			var tubeInstance : Bullet = Global.createObject(get_tree().root,TEST_TUBE_PATH,global_position + Vector2(160.0,0.0));
			tubeInstance.setSpeed(15.0);
			tubeInstance.setAcceleration(1.5);
			tubeInstance.setMaxSpeed(35.0);
			tubeInstance.setDirection(Vector2(1.0,0.0));
			
			get_tree().root.add_child(tubeInstance);
			changeSpriteFrame("shooting")
			

func takeAHit(hpLoss: int):
	if !takingDamage and damageCooldownTimer <= 0.0 and !invincible:
		
		if Global.PlayerHP <= hpLoss:
			die()
		else:
			Global.playSound(get_tree().root,"res://sounds/assets/sfx/snd_hurt.wav",global_position);
			
			var hurtSnd = "res://sounds/assets/sfx/snd_adele_hurt_1.wav";
			if (randi() % 2 == 0):
				hurtSnd = "res://sounds/assets/sfx/snd_adele_hurt_2.wav";
			
			Global.playSound(get_tree().root,hurtSnd,global_position);
			Global.PlayerHP -= hpLoss;
			takingDamage = true;
			damageCounter = DAMAGE_TIME;
			shootingCooldown = 0.0;
			changeSpriteFrame("hurt");

func die():
	Global.PlayerHP = 0;
	Global.Lives -= 1;
	Global.createObject(get_tree().root,"res://objects/particles/poofCloud.tscn",global_position);
	Global.startRespawnTimer();
	Global.playSound(get_tree().root,"res://sounds/assets/sfx/snd_death.wav",global_position);
	queue_free();

func changeSpriteFrame(name: String):
	sprite.play(name,1.0,false)
	sprite.offset = spriteOffsets[name];
	pass

func collect():
	pass
