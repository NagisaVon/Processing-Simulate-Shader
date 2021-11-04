
PVector iResolution;

color sim_fragshader(PVector FragCoord, float t) {
    PVector uv = new PVector(FragCoord.x / iResolution.x, FragCoord.y / iResolution.y);
    
    return color(abs(sin(t)), uv.x, uv.y, 1.0);  
}

float smoothstep(float start, float stop, float val) {
    if (val < start) return 0.0f;
    if (val >= stop) return 1.0f;
    float k = constrain((val-start)/(stop-start), 0, 1);
    return k*k*(-2*k+3);
}

float step(float val, float threshold) {
    return(val>threshold ? 1.: 0.);
}

void setup() { 
    size(400, 400);
    colorMode(RGB, 1);
    iResolution = new PVector(width, height);
} 

void draw() { 
    background(0);
    loadPixels();
    
    for (float i = 0; i < width; ++i) {
        for (float j = height - 1; j >= 0; --j) {
            pixels[int(j*width + i)] = sim_fragshader(new PVector(i, height-1-j), millis()/1000.);
        }
    }
    updatePixels();
} 
