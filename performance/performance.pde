
PVector iResolution;
float ratio; 

float circleSDF(PVector st, PVector center) {
    st.x *= ratio;
    center.x *= ratio;
    return st.sub(center).mag();  
}

float sdf_fill(float x, float size) {
    return (1.0-step(x, size));
}


color sim_fragshader(PVector FragCoord, float t) {
    PVector st = new PVector(FragCoord.x / iResolution.x, FragCoord.y / iResolution.y);
    float val = 0;
    
    for(float i = 0.; i < 100.; ++i) {
        // !!! Notice here can't use st, or java will modify st
        val += sdf_fill(circleSDF(new PVector(st.x, st.y), new PVector(i*.01, i*.01)), .005);
    }
    
    color c = color( val );
    return c;  
}

// don't use this for now, start can only be lower than stop 
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
    size(600, 400);
    colorMode(RGB, 1);
    iResolution = new PVector(width, height);
    
    // who the fuck knows you need (float)
    ratio = (float)width/height;
} 

float lasttime = millis();

void draw() { 

    // Shader Implementation
    // around 150ms
    loadPixels();
    for (float j = height - 1; j >= 0; --j) {
        for (float i = 0; i < width; ++i) {
            pixels[int(j*width + i)] = sim_fragshader(new PVector(i, height-1-j), millis()/1000.);
        }
    }
    updatePixels();
    text(str(millis()-lasttime), 20, 20);
    lasttime = millis();

    // Non-Shader Implementation
    // around 12ms
    // background(0);
    // noStroke();
    // fill(1);
    // for (float i = 0; i < 100; ++i) {
    //     circle(i*6, i*4, 2);
    // }
    // text(str(millis()-lasttime), 20, 20);
    // lasttime = millis();
} 
