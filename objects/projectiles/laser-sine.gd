extends Bullet;

var Polygon: Polygon2D ;
var Hitbox: CollisionPolygon2D;

var x = -10.0;
var length = 0;

const MAX_LENGTH = 40;
const SIZE_GRADIENT = 5;
const RADIUS = 25.0 / SIZE_GRADIENT;
const SPEED = 21.0;
const AMPLITUDE = 120.0;
const FREQUENCY = 0.4;

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready();
	Polygon = $CanvasGroup/Polygon2D;
	Hitbox = $Hitbox;
	visibilityNotifier = $VisibleOnScreenEnabler2D;
	speed = 0.0;
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta);
	var pol = Polygon.polygon;
	
	var insertIndex = (pol.size() / 2);
	
	var height = sin(((x / SPEED) / PI) * FREQUENCY) * AMPLITUDE;
	
	pol.insert(insertIndex,Vector2(x,height + RADIUS));
	pol.insert(insertIndex,Vector2(x,height - RADIUS));
	length += 1;
	
	if(pol.size()>SIZE_GRADIENT*2):
		enlargeLaser(pol,insertIndex);
	
	if length >= MAX_LENGTH:
		thinLaser(pol);
		pol.remove_at(0);
		pol.remove_at(pol.size() - 1);
		visibilityNotifier.position.x = pol[0].x;
		if ! visibilityNotifier.is_on_screen():
			destroy();
	
	Polygon.set_polygon(pol);
	x -= SPEED;
	
func enlargeLaser(pol,insertIndex):
	for i in range(1,SIZE_GRADIENT+1):
		pol[insertIndex-i].y -= RADIUS;
		
	for i in range(2,SIZE_GRADIENT+2):
		pol[insertIndex+i].y += RADIUS;

func thinLaser(pol):
	for i in range(1,SIZE_GRADIENT+1):
		pol[i].y += RADIUS;
	
	for i in range(2,SIZE_GRADIENT+2):
		pol[pol.size()-i].y -= RADIUS;

func _physics_process(delta):
	Hitbox.set_polygon(Polygon.polygon);

func impact():
	pass;
