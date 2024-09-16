shader_type canvas_item;

uniform float amplitude : hint_range(0.0, 1.0) = 0.1;
uniform float frequency : hint_range(0.0, 10.0) = 2.0;
uniform float speed : hint_range(0.0, 10.0) = 1.0;
uniform bool enable_sway_x = false;
uniform float sway_x_amplitude : hint_range(0.0, 1.0) = 0.1;

void vertex() {
    float swayAmountY = amplitude * sin(TIME * frequency + VERTEX.y * speed);
    
    float swayAmountX = 0.0;
    if (enable_sway_x) {
        swayAmountX = sway_x_amplitude * sin(TIME * frequency + VERTEX.x * speed);
    }


    VERTEX.y += swayAmountY;
    VERTEX.x += swayAmountX;
}
