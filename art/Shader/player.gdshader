shader_type canvas_item;

uniform bool active = false;
uniform bool invisible = false;
uniform bool fire = false;
uniform vec4 black : source_color;
uniform vec4 newColor : source_color;
uniform vec4 eye : source_color;
uniform vec4 white : source_color;
uniform vec4 sword : source_color;
uniform vec4 sangue : source_color;
uniform vec4 capelli : source_color;
uniform vec4 newCapelli: source_color;

void fragment() {
	if (active) {
		vec4 previusColor = texture(TEXTURE, UV);
		vec4 blink = vec4(1.0, 1.0, 1.0, previusColor.a);
		COLOR = blink;
	}

	if (invisible) {
		vec4 currColor = texture(TEXTURE, UV);
		if (currColor != black && currColor != eye && currColor != white) {
		  COLOR = newColor;
		}

		if (currColor == black) {
		 COLOR = white;
		}
	}

	if (fire) {
		vec4 previusColor = texture(TEXTURE, UV);
		if (previusColor == sword) {
			COLOR = sangue;
		}
	}
	
	
}
