
float shader_step(float val, float threshold) {
    return(val>threshold ? 1.: 0.);
}

color sim_frag_shader(float coord_x, float coord_y) {
    float y = shader_step(coord_x, 0.3);
    color fragColor = color(y); // glfragColor
    return fragColor;
}

void setup() { 
    size(400, 400);
    colorMode(RGB, 1);
    background(0);
    loadPixels();
    for (float i = 0; i < width; i++) {
        for (float j = 0; j < height; j++) {
            pixels[int(j*width + i)] = sim_frag_shader(i/width, j/height);
        }
    }
    updatePixels();
} 

void draw() { 
    
} 
