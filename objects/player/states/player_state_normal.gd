extends PlayerState

class_name PlayerState_Normal


func process(d):

	player.delta = d * Global.FPS_CAP;
	clampf(player.delta,1.0,2.0);
	
	player.check_inputs();
	
	player.move();
	
	if Input.is_action_pressed("focus"):
		player.focusing = true;
	else:
		player.focusing = false;
	
	
	player.constantCounter += 1;
	
	if player.focusing:
		player.sprite.modulate.a = 0.5;
		player.hitboxSprite.visible = true;
	else:
		player.sprite.modulate.a = 1;
		player.hitboxSprite.visible = false;

func check_inputs():
	if Input.is_action_pressed("ui_left"):
		player.direction.x = -1;
	elif Input.is_action_pressed("ui_right"):
		player.direction.x = 1;
	else:
		player.direction.x = 0;

	if Input.is_action_pressed("ui_up"):
		player.direction.y = -1;
	elif Input.is_action_pressed("ui_down"):
		player.direction.y = 1;
	else:
		player.direction.y = 0;
	
	if Input.is_action_pressed("shoot"):
		player.shoot();
	
	if player.direction == Vector2(0,0):
		player.speed = 0;
	else:
		if(player.focusing):
			player.speed = player.FOCUS_SPEED;
		else:
			player.speed = player.MAX_SPEED;
		player.direction = player.direction.normalized();

func takeAHit(hpLoss: int):
	if !player.invincible:
		
		if Global.PlayerHP <= hpLoss:
			player.die()
		else:
			Utils.playSound("res://sounds/assets/sfx/snd_hurt.wav",player.position);
			
			var hurtSnd = "res://sounds/assets/sfx/snd_adele_hurt_1.wav";
			if (randi() % 2 == 0):
				hurtSnd = "res://sounds/assets/sfx/snd_adele_hurt_2.wav";
			
			Utils.playSound(hurtSnd,player.position);
			Global.PlayerHP -= hpLoss;
			player.changeSpriteFrame("hurt");
			player.changeState(PlayerState_Damaged.new());
			player.damagedTimer.start();
