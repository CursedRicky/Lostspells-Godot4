shader_type canvas_item;

uniform float ghost_progress: hint_range(0.0, 1.0);

void fragment() {
	// Set original color pallete to purple
	vec3 purple_swizzle = COLOR.gbr;
	vec4 base_joe_tex = vec4(purple_swizzle, COLOR.a);

	// UV mapping to 'move texture up'
	vec2 fly_up_uv = vec2(UV.x, UV.y + ghost_progress / 2.0);
	// Sample color data from texture
	float mipmap_index = ghost_progress * 4.5;
	vec4 ghost_tex = textureLod(TEXTURE, fly_up_uv, mipmap_index);
	
	// Set ghost like propperties: light color and transparency
	ghost_tex.rgb = ghost_tex.rrr * 1.7;
	float ghost_opacity = 0.8;
	ghost_tex.a *= ghost_opacity - ghost_opacity * ghost_progress;
	
	COLOR.rgba = mix(ghost_tex.rgba, base_joe_tex.rgba, COLOR.a);
}
