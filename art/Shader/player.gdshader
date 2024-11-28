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
uniform vec4 pelle0: source_color;
uniform vec4 pelle1: source_color;

uniform int selector = 1;

bool colorMatch(vec4 c1, vec4 c2, float maxDiff) {
    return (
        abs(c1.r - c2.r) < maxDiff
        && abs(c1.g - c2.g) < maxDiff
        && abs(c1.b - c2.b) < maxDiff
    );
}

void fragment() {
	vec4 crc = texture(TEXTURE, UV);
	
	switch (selector) {
		case 0:
			if (!colorMatch(crc, pelle1, .3))
				COLOR.rgb = COLOR.rrr;
		case 1:
			if (!colorMatch(crc, pelle1, .3))
				COLOR.rgb = COLOR.ggg;
		case 2:
			if (!colorMatch(crc, pelle1, .3))
				COLOR.rgb = COLOR.bbb;
		case 3:
			if (!colorMatch(crc, pelle1, .3))
				COLOR.rgb = COLOR.rrg;
		case 4:
			if (!colorMatch(crc, pelle1, .3))
				COLOR.rgb = COLOR.ggr;
		case 5:
			if (!colorMatch(crc, pelle1, .3))
				COLOR.rgb = COLOR.ggb;
		case 6:
			if (!colorMatch(crc, pelle1, .3))
				COLOR.rgb = COLOR.rbg;
		case 7:
			if (!colorMatch(crc, pelle1, .3))
				COLOR.rgb = COLOR.bgr;
		case 8:
			if (!colorMatch(crc, pelle1, .3))
				COLOR.rgb = COLOR.brg;
		case 9:
			if (!colorMatch(crc, pelle1, .3))
				COLOR.rgb = COLOR.gbr;
		case 10:
			if (!colorMatch(crc, pelle1, .3))
				COLOR.rgb = COLOR.gbb;
	};
	
	
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
