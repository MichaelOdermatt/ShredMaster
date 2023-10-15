shader_type canvas_item;

uniform vec4 gradient_color: source_color = vec4(1.0);
uniform float speed: hint_range(0.0, 10.0) = 0.5;
uniform float angle: hint_range(0.0, 360.0) = 0.0;
uniform float scale: hint_range(2.0, 50.0) = 2.0;

float timeOffset(float value) {
	return value + (TIME * speed);
}

void fragment() {
	float hue = UV.x * cos(radians(angle)) - UV.y * sin(radians(angle));
	hue = timeOffset(hue);
	float x = abs(mod(hue * scale, 2.0) - 1.0);
	vec4 pixelColor = texture(TEXTURE, UV);
	COLOR.rgb = mix(pixelColor.rgb, gradient_color.rgb, x);
}
