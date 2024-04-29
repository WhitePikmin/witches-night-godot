extends Node

class_name PlayerState

var player: Player;

func setup(p: Player):
	player = p;


func process(d):
	pass

func check_inputs():
	pass

func shoot():
	if player.shootingCooldown:
			player.shootingCooldown = false;
			player.shootCooldownTimer.start();
			var tubeInstance : Bullet = Utils.createObject(player.TEST_TUBE_PATH,player.position + Vector2(160.0,0.0));
			tubeInstance.setSpeed(15.0);
			tubeInstance.setAcceleration(1.5);
			tubeInstance.setMaxSpeed(35.0);
			tubeInstance.setDirection(Vector2(1.0,0.0));
			
			get_tree().root.add_child(tubeInstance);
			player.changeSpriteFrame("shooting")

func takeAHit(hpLoss: int):
	pass

func shotCoolDown():
	player.shootingCooldown = true;
	player.changeSpriteFrame("default");

func unDamage():
	pass

func removeGracePeriod():
	pass
