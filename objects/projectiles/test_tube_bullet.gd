extends Bullet;

func impact():
	Utils.createObject("res://objects/particles/bottleShatter.tscn",position + Vector2(5.0,0.0));
	Utils.playSound("res://sounds/assets/sfx/snd_glass_break.wav",position);
	destroy();
