
float smoothstep(float start, float stop, float val) {
    if (val < start) return 0.0f;
    if (val >= stop) return 1.0f;
    // val-start the the y value of the curve
    // stop-start is the length of the range 
    // this is not return lerp(0, 1, (val-start)/(stop-start));
    // lerp is a linear interpolation, but it's not smooth
    // this smooth transition is achieved by combining two parabola functions:
    // a = x^2, b = 1-(x-1)^2
    // lerp between a and b: a(1-x)+bx  (imagine at the start x for a(actually 1-x) is 1, and x for b is 0, then lerp between 1 and 0) 
    // = x^2(-2x+3), and we only want the range(0, 1), so we clamp it to 0 and 1
    // using the processing constrain(amt, low, high) function

    // (val-start)/(stop-start) is the x in the fomula above
    // this is equivalent to (min (max k 0) 1) 
    float k = constrain((val-start)/(stop-start), 0, 1);
    return k*k*(-2*k+3);

}

color sim_fragshader(float coord_x, float coord_y) {
    float y = smoothstep(0.2,0.5,coord_x) - smoothstep(0.5,0.8,coord_x);
    //float y = smoothstep(0.2,0.5,coord_x);
    color fragColor = color(y); 
    return fragColor; 
}

void setup() { 
    size(400, 400);
    colorMode(RGB, 1);
    background(0);
    // simulate shader by start drawing from lower left corner
    loadPixels();
    for (float i = 0; i < width; ++i) {
        for (float j = height - 1; j >= 0; --j) {
            // also simulate shader by let x and y be 0 at the lower left corner 
            pixels[int(j*width + i)] = sim_fragshader(i/width, 1-j/height);
        }
    }
    updatePixels();
} 

void draw() { 
    
} 
