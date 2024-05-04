extends Enemy
class_name Boss

var state: BossState;

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready();


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(d):
	super._process(d);
	state._process(d)

func changeState(newState: BossState):
	remove_child(state);
	state.queue_free();
	newState.setup(self);
	state = newState;
	add_child(state);

func setSprite(spr: AnimatedSprite2D):
	sprite = spr;
	sprite.set_material(sprite.get_material().duplicate());
	sprite.get_material().set_shader_parameter("strength", 0.0);

func collideWithPlayerBullet():
	state.collideWithPlayerBullet();

func takeAHit(hpLoss: int):
	state.takeAHit(hpLoss);

func stopFlashing():
	state.stopFlashing();

func die():
	state.die();

func spawnStars(count):
	state.spawnStars(count);

func startHostility():
	pass
