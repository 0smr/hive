varying highp vec2 qt_TexCoord0;
uniform highp float qt_Opacity;
uniform highp vec4 color;
uniform highp vec4 strokeColor;
uniform highp vec4 _c;
uniform highp float width;
uniform highp float height;
uniform highp float strokeWidth;
uniform highp float _radius;

float cornerCalc(in vec2 p, in vec4 cr) {
    cr.xy = p.x < .5 ? cr.xw : cr.yz;
    return p.y < .5 ? cr.x : cr.y;
}

float box(vec2 p, vec2 halfSize, vec2 cr, float rad) {
   p = abs(p) - halfSize + rad;
   cr -= rad/2.;
   vec2 d1 = vec2(max(p.x + cr.x, 0.0), p.y);
   vec2 d2 = vec2(p.x, max(p.y + cr.y, 0.0));
   p.x += cr.x;
   vec2 end = vec2(cr.x, -cr.y);
   vec2 d3 = p - end * clamp(dot(p, end) / dot(end, end), 0.0, 1.0);
   float s = sign(max(d3.x, d1.y));
   return sqrt(min(min(dot(d1, d1), dot(d2, d2)), dot(d3, d3))) * s - rad;
}

void main() {
    float sw = strokeWidth/min(width, height);
    float mn = 1./min(width, height);
    vec2 rat = vec2(width, height)/min(width, height);
    vec2 p = qt_TexCoord0 * rat * 2. - rat;
    float d = box(p, rat - sw - mn, cornerCalc(qt_TexCoord0, _c) - sw/2., _radius - sw);
    gl_FragColor = color * (1. - smoothstep(0., mn, d));
    gl_FragColor = mix(gl_FragColor, strokeColor, (1. - smoothstep(0., mn, abs(d) - sw))) * qt_Opacity;
}
