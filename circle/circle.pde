float shader_circle(float x, float y) {
    return shader_step(dist(x, y, 0.5, 0.5), 0.3);  //dist(center.xy, radius.xy)
}

float shader_step(float val, float threshold) {
    return(val>threshold ? 1.: 0.);
}

color sim_frag_shader(float coord_x, float coord_y) {
    color fragColor = color(shader_circle(coord_x, coord_y)); // glfragColor
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
