// a simulate of https://www.shadertoy.com/view/XsXXDn
// credits to 'Danilo Guanabara'

// void mainImage( out vec4 fragColor, in vec2 fragCoord ){
// 	vec3 c;
// 	float l,z=t;
// 	for(int i=0;i<3;i++) {
// 		vec2 uv,p=fragCoord.xy/r;
// 		uv=p;
// 		p-=.5;
// 		p.x*=r.x/r.y;
// 		z+=.07;
// 		l=length(p);
// 		uv+=p/l*(sin(z)+1.)*abs(sin(l*9.-z-z));
// 		c[i]=.01/length(mod(uv,1.)-.5);
// 	}
// 	fragColor=vec4(c/l,t);
// }

// adding time to the shader

PVector iResolution;
float ratio; 


color sim_fragshader(PVector FragCoord, float t){
    float cr = 0, cg = 0, cb = 0;
    float z = t;
    
    PVector p = new PVector(FragCoord.x / iResolution.x, FragCoord.y / iResolution.y);
    PVector uv = new PVector(p.x, p.y);
    p.sub(0.5, 0.5);
    p.x *= ratio;
    z += .07;
    float l = p.mag();
    for (int i = 0; i < 3; i++) {
        // deal the center case where l = 0
        if(l != 0) {
            uv = new PVector(FragCoord.x / iResolution.x, FragCoord.y / iResolution.y);
            uv.add(p.div(l).mult( (sin(z) + 1.) * abs(sin(l * 9. - z - z))));
        }

        if (i == 0) {
            cr = .01/ new PVector(uv.x%1.0, uv.y%1.0).sub(0.5, 0.5).mag();
        }
        if (i == 1) {
            cg = .01/ new PVector(uv.x%1.0, uv.y%1.0).sub(0.5, 0.5).mag();
        }
        if (i == 2) {
            cb = .01/ new PVector(uv.x%1.0, uv.y%1.0).sub(0.5, 0.5).mag();
        }
    
    }
    
    return color(cr/l, cg/l, cb/l, 1.);
}


void setup() { 
    size(400, 400);
    colorMode(RGB, 1);
    iResolution = new PVector(width, height);
    ratio = (float)width/height;
} 

void draw() { 

    loadPixels();
    for (float j = height - 1; j >= 0; --j) {
        for (float i = 0; i < width; ++i) {
            pixels[int(j*width + i)] = sim_fragshader(new PVector(i, height-1-j), millis()/1000.);
        }
    }
    updatePixels();
    text(str(frameRate), 20, 20);
} 
