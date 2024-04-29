extends PlayerState

class_name PlayerState_Normal


func process(d):

	player.delta = d * Global.FPS_CAP;
	clampf(player.delta,1.0,2.0);
	
	if player.shootingCooldown > 0.0:
		player.shootingCooldown -= player.delta;
		if player.shootingCooldown <= 0.0:
			player.changeSpriteFrame("default");
			
	if player.damageCooldownTimer > 0.0:
		player.sprite.visible = ((player.constantCounter / 3) % 2 == 0);
		player.damageCooldownTimer -= player.delta;
		if player.damageCooldownTimer <= 0.0:
			player.sprite.visible = true;
			
	player.check_inputs();
	
	player.move();
	
	player.constantCounter += 1;

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
		player.speed = player.MAX_SPEED;
		player.direction = player.direction.normalized();

func takeAHit(hpLoss: int):
	if player.damageCooldownTimer <= 0.0 and !player.invincible:
		
		if Global.PlayerHP <= hpLoss:
			player.die()
		else:
			Utils.playSound("res://sounds/assets/sfx/snd_hurt.wav",player.position);
			
			var hurtSnd = "res://sounds/assets/sfx/snd_adele_hurt_1.wav";
			if (randi() % 2 == 0):
				hurtSnd = "res://sounds/assets/sfx/snd_adele_hurt_2.wav";
			
			Utils.playSound(hurtSnd,player.position);
			Global.PlayerHP -= hpLoss;
			player.damageCounter = player.DAMAGE_TIME;
			player.shootingCooldown = 0.0;
			player.changeSpriteFrame("hurt");
			player.changeState(PlayerState_Damaged.new());
