shader_type canvas_item;

uniform float magnitude;
uniform float frequency = 1.0;

void vertex() {
	VERTEX.y += cos(TIME * frequency) * magnitude;
}
