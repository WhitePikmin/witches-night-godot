extends Node
class_name BossState

var boss: Boss;

func setup(b:Boss):
	boss = b;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if boss.flashTimer > 0:
		boss.flashTimer -= 1;
	elif boss.flashTimer == 0:
		boss.stopFlashing();
		boss.flashTimer = -1;
		
	if boss.HP <= 0:
		boss.die();

func collideWithPlayerBullet():
	var result = boss.move_and_collide(Vector2(0,0),true,0.0,false);
	if result != null:
		var collidedObject = result.get_collider();
		if collidedObject.get_collision_layer_value(4):
			collidedObject.queue_free();
			boss.HP -= collidedObject.damage;

func takeAHit(hpLoss: int):
	boss.HP -= hpLoss;
	boss.sprite.get_material().set_shader_parameter("strength", 1.0);
	boss.flashTimer += 6;

func stopFlashing():
	boss.sprite.get_material().set_shader_parameter("strength", 0.0);

func die():
	Utils.createObject("res://objects/particles/poofCloud.tscn",boss.position);
	var snd = Utils.createObject("res://sounds/SoundEmitter.tscn",boss.position);
	snd.stream = load("res://sounds/assets/sfx/snd_poof.wav");
	snd.play();
	queue_free();

func spawnStars(count):
	for i in range(count):
		var star = Utils.createObject("res://objects/items/star_item.tscn",boss.position);
		star.position += Vector2(randi_range(-10,10),randi_range(-10,10));
		star.direction += Vector2(randf_range(-0.3,0.3),randf_range(-0.3,0.3));

func getOnRail():
	if get_parent() != Utils.railObject:
		get_parent().remove_child(self);
		boss.position -= Utils.railObject.global_position;
		Utils.railObject.add_child(self);
