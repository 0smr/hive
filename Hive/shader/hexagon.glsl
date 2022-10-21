uniform highp float qt_Opacity;
varying highp vec2 qt_TexCoord0;
uniform highp vec2 ratio;
uniform highp vec4 sc;
uniform highp vec4 color;
uniform highp float mx;
uniform highp float sw;
uniform highp float rad;

float sdHexagon(vec2 p, float s, float r) {
    const vec3 k = vec3(-0.866025404, 0.5, 0.577350269);
    p = abs(p);
    p -= 2.0 * min(dot(k.xy,p),0.0)*k.xy;
    p -= vec2(clamp(p.x, -k.z*s, k.z*s), s);
    return length(p)*sign(p.y) - r;
}

void main() {
    vec2 u = qt_TexCoord0/ratio.yx - 0.5 - vec2(0.086,0);
    float eDist = sdHexagon(u, 0.47 - rad, -0.5 + rad);
    gl_FragColor = mix(color, vec4(0.), smoothstep(0., 1./mx, eDist - .5));
    gl_FragColor = mix(sc, gl_FragColor,
                       smoothstep(0., 1./mx, abs(eDist - .5 + sw) - sw + 0.5/mx));
    gl_FragColor *= qt_Opacity;
}
