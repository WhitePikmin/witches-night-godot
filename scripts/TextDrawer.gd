extends Node2D

@onready var charSprite = load("res://misc/spr_char.tscn");
var text = "";
var chars = [];

const CHAR_SIZE = 16 * 3;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_text(txt:String):
	text = txt;

func setPosition(pos:Vector2):
	position = pos;

func display_text():
	var i = 0
	for c in text:
		if i < chars.size():
			chars[i].setChar(c);
		else:
			var character = _createChar(Vector2(i * CHAR_SIZE,0));
			character.setChar(c);
		
		i += 1;
		
	while i < chars.size():
		chars[i].setChar(" ");
		i += 1;
		
	pass
	

func _createChar(pos: Vector2):
	var obj = charSprite;
	var instance = obj.instantiate();
	chars.append(instance);
	instance.position = pos;
	self.add_child(instance);
	return instance;
