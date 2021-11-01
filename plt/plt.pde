float plt(float x, float y, float pct) {
    
}

float smoothstep(float start, float stop, float val) {
    if (val < start) return 0.0f;
    if (val >= stop) return 1.0f;
    return lerp(0, 1, (val-start)/(stop-start));
}

color sim_fragshader(float coord_x, float coord_y) {
    // float y = shader_smoothstep(0.2,0.5,coord_x) - shader_smoothstep(0.5,0.8,coord_x);
    float y = smoothstep(0.2,0.5,coord_x);
    color fragColor = color(y); 
    return fragColor; 
}

void setup() { 
    size(400, 400);
    colorMode(RGB, 1);
} 

void draw() { 
    background(0);
    loadPixels();
    for (float i = 0; i < width; i++) {
        for (float j = 0; j < height; j++) {
            pixels[int(j*width + i)] = sim_fragshader(i/width, j/height);
        }
    }
    updatePixels();
} 
