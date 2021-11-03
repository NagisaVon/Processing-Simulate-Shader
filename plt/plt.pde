// draw a curve to represent a x-val relationship
float plt(float x, float y, float val) {
    return smoothstep( val-0.02, val, y ) - smoothstep( val, val+0.02, y ); // upper half - lower half
    // the weight of curve currently is 0.02*2 = 0.04
    // this could draw any curves if you change the third parameter of smoothstep
}

color sim_fragshader(float x, float y) {
    // this is orginally called y by thebookofshader 
    // but I call it val, and the image, from left to right reflects the val 
    // I might change my mind as codin goes on, also in the bookofshader he used pct
    // (maybe means percentage) to reflect the val, but I think I'm going to use val

    // val is 0 when x = 0.2 and smoothly goes to 1 when x reaches 0.5
    float val = smoothstep(0.1, 0.9, x); 
    float p = plt(x,y,val);
    // a green curve merges with a background color val as x increases
    // when p = 1, the background color(val) dodge the curve(p)
    
    return color((1-p)*val, (1-p)*val+p, (1-p)*val, 1.0); // gl_FragColor 
}



float smoothstep(float start, float stop, float val) {
    if (val < start) return 0.0f;
    if (val >= stop) return 1.0f;
    float k = constrain((val-start)/(stop-start), 0, 1);
    return k*k*(-2*k+3);
}

void setup() { 
    size(400, 400);
    colorMode(RGB, 1);
} 

void draw() { 
    background(0);
    loadPixels();
    // simulate shader by start drawing from lower left corner
    for (float i = 0; i < width; ++i) {
        for (float j = height - 1; j >= 0; --j) {
            // also simulate shader by let x and y be 0 at the lower left corner 
            pixels[int(j*width + i)] = sim_fragshader(i/width, 1-j/height);
        }
    }
    updatePixels();
} 
