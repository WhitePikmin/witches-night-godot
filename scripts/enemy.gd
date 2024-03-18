extends Movable
class_name Enemy

@onready var GLOBAL: Node = get_node("Global");

var HP: int = 5;
var sprite: AnimatedSprite2D;
var flashTimer: int = -1;

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready();


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(d):
#	d = 0.016;
	super._process(d);
	if flashTimer > 0:
		flashTimer -= 1;
	elif flashTimer == 0:
		stopFlashing();
		flashTimer = -1;
		
	if HP <= 0:
		die();

func setSprite(spr: AnimatedSprite2D):
	sprite = spr;
	sprite.set_material(sprite.get_material().duplicate());
	sprite.get_material().set_shader_parameter("strength", 0.0);

func collideWithPlayerBullet():
	var result = move_and_collide(Vector2(0,0),true,0.0,false);
	if result != null:
		var collidedObject = result.get_collider();
		if collidedObject.get_collision_layer_value(4):
			collidedObject.queue_free();
			HP -= collidedObject.damage;

func takeAHit(hpLoss: int):
	HP -= hpLoss;
	sprite.get_material().set_shader_parameter("strength", 1.0);
	flashTimer += 6;

func stopFlashing():
	sprite.get_material().set_shader_parameter("strength", 0.0);

func die():
	Global.createObject(get_tree().root,"res://objects/particles/poofCloud.tscn",global_position);
	var snd = Global.createObject(get_tree().root,"res://sounds/SoundEmitter.tscn",global_position);
	snd.stream = load("res://sounds/assets/sfx/snd_poof.wav");
	snd.play();
	queue_free();

func spawnStars(count):
	for i in range(count):
		var star = Global.createObject(get_tree().root,"res://objects/items/star_item.tscn",global_position);
		star.position += Vector2(randi_range(-10,10),randi_range(-10,10));
		star.direction += Vector2(randf_range(-0.3,0.3),randf_range(-0.3,0.3));
