shader_type canvas_item;

uniform bool blink = false;
uniform bool freeze = false;

uniform vec4 freeze_color: source_color;
uniform float freeze_intensity = 0;

void fragment() {
	
	vec4 color = texture(TEXTURE, UV);
	color = mix(color, freeze_color, freeze_intensity * color.a);
	COLOR = color;
}
