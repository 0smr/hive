uniform sampler2D source;
uniform sampler2D strokeSource;
uniform highp float qt_Opacity;
varying highp vec2 qt_TexCoord0;
uniform highp vec2 ratio;
uniform highp vec2 s;
uniform highp vec4 color;
uniform highp vec4 strokeColor;
uniform highp float strokeWidth;
uniform lowp int size;
uniform lowp bool flatSide;
uniform lowp bool mask;
uniform lowp bool strokeMask;

float hash21(vec2 p) { return fract(sin(dot(p, vec2(141.13, 289.97)))*43758.5453); }

float hex(in vec2 p) {
    p = abs(p);
    float _p = mix(p.y, p.x,float(flatSide));
    return max(dot(p, s*.5), _p);
}

vec4 getHex(vec2 p) {
    vec2 v = vec2(1.,.5);
    vec4 hC = floor(vec4(p, p - mix(v.xy,v.yx,float(flatSide)))/vec4(s.xy,s.xy)) + .5;
    vec4 h = vec4(p - hC.xy*s, p - (hC.zw + .5)*s);
    return dot(h.xy, h.xy) < dot(h.zw, h.zw) ? vec4(h.xy, hC.xy) : vec4(h.zw, hC.zw + .5);
}

void main() {
    vec2 u = qt_TexCoord0/ratio.yx * size;
    vec4 h = getHex(u + s.yx);
    vec2 hpos = floor(h.zw + 0.5)/size;
    if(mask) color = texture2D(source, hpos/s.yx*ratio.yx * max(s.y,s.x) - 0.025);
    if(strokeMask) strokeColor = texture2D(strokeSource, hpos/s.yx * ratio.yx * max(s.y,s.x) - 0.02);
    float eDist = hex(h.xy);
    gl_FragColor = mix(color, strokeColor, smoothstep(0., .03, eDist - .5 + strokeWidth/2));
}
