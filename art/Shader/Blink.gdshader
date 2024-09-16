shader_type canvas_item;

uniform bool blink = false;
uniform bool freeze = false;

uniform vec4 freeze_color: source_color;
uniform float freeze_intensity = 0;

void fragment() {
	vec4 previusColor = texture(TEXTURE, UV);
	vec4 white = vec4(1.0, 1.0, 1.0, previusColor.a);
	COLOR = white;
}
