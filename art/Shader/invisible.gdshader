shader_type canvas_item;

uniform bool active = false;
uniform vec4 black : source_color;
uniform vec4 newColor : source_color;
uniform vec4 eye : source_color;
uniform vec4 white : source_color;

void fragment() {
	 vec4 currColor = texture(TEXTURE, UV);
	 if (currColor != black && currColor != eye && currColor != white) {
	  COLOR = newColor;
	 }

	if (currColor == black) {
	 COLOR = white;
	}

}