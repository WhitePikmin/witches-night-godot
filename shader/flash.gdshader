shader_type canvas_item;

uniform vec3 white = vec3(1.0,1.0,1.0);
uniform float strength = 0.0;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	COLOR = texture(TEXTURE, UV); // Read from texture
	COLOR = vec4(
		COLOR.r + strength,
		COLOR.g + strength,
		COLOR.b + strength,
		COLOR.a);
}