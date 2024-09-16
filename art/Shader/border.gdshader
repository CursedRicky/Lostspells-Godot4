shader_type canvas_item;
render_mode unshaded;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture;
uniform vec4 outline_color : source_color;

void fragment() {
	float size_x = 1.0/float(textureSize(TEXTURE, 0).x);
	float size_y = 1.0/float(textureSize(TEXTURE, 0).y);
	vec4 spriteColor = texture(TEXTURE, UV);
	float alpha = -4.0 * spriteColor.a;
	alpha += texture(TEXTURE, UV + vec2(size_x, 0)).a;
	alpha += texture(TEXTURE, UV + vec2(-size_x, 0)).a;
	alpha += texture(TEXTURE, UV + vec2(0, size_y)).a;
	alpha += texture(TEXTURE, UV + vec2(0, -size_y)).a;
	vec4 final_color = mix(spriteColor, outline_color, clamp(alpha, 0.0, 1.0));
	COLOR = vec4(final_color.rgb, clamp(abs(alpha) + spriteColor.a, 0.0, 1.0));
}
