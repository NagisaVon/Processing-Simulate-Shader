#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

vec3 colorB = vec3(0.4,0.4,0.7);
vec3 colorA = vec3(0.95,0.67,0.2);

float plot (float axis, float pct){
  return  smoothstep( pct-0.01, pct, axis) -
          smoothstep( pct, pct+0.01, axis);
}

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    vec3 color = vec3(0.0);

    vec3 pct = vec3(pow(st.y,0.4));

    // pct.r = smoothstep(0.0,1.0, st.x);
    // pct.g = sin(st.x*PI);
    // pct.b = pow(st.x,0.5);

    color = mix(colorA, colorB, pct);

    // Plot transition lines for each channel

    color = mix(color,vec3(1.0,0.0,0.0),plot(st.x,pct.r));
    color = mix(color,vec3(0.0,1.0,0.0),plot(st.x,pct.g));
    color = mix(color,vec3(0.0,0.0,1.0),plot(st.x,pct.b));

    gl_FragColor = vec4(color,1.0);
}
