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
color sim_fragshader(float x, float y, float t) {
    float cr = 0, cg = 0, cb = 0;
    float z = t;
    float u = x;
    float v = y;
    float kx = (x-.5)*width/height;
    float ky = y-.5;
    float l = mag(kx, ky);
    for (int i = 0; i < 3; i++) {
        z += .07;
        // deal the center case where l = 0
        if(l != 0) {
            u = x;
            v = y;
            u += kx / l * (sin(z) + 1.) * abs(sin(l * 9. - z - z));
            v += ky / l * (sin(z) + 1.) * abs(sin(l * 9. - z - z));
        }
        
        if (i == 0) {
            cr = .01 / mag(u%1.0-.5, v%1.0-.5); // %1.0 left you  get the fractional part
        }
        if (i == 1) {
            cg = .01 / mag(u%1.0-.5, v%1.0-.5);
        }
        if (i == 2) {
            cb = .01 / mag((u%1.0)-.5, (v%1.0)-.5);
        }
        // DEBUG
        if (x == 0.51 && y == 0.3) {
            //println("kx: ", kx," ky: ", ky, " cr: ", cr, " cg: ", cg, " cb: ", cb, " l: ", l, " z: ", z,  " u: ", u, " v: ", v);
        }
    }
    return color(cr/l, cg/l, cb/l, 1.);
}

float smoothstep(float start, float stop, float val) {
    if (val < start) return 0.0f;
    if (val >= stop) return 1.0f;
    float k = constrain((val - start) / (stop - start), 0, 1);
    return k * k * ( - 2 * k + 3);
}

void setup() { 
    size(400, 400);
    colorMode(RGB, 1);
} 

void draw() { 
    background(0);
    loadPixels();
    for (float i = 0; i < width; ++i) {
        for (float j = height - 1; j >= 0; --j) {
            // time is in seconds
            pixels[int(j * width + i)] = sim_fragshader(i / width, 1. - j / height, millis()/1000.);
        }
    }
    updatePixels();
} 
