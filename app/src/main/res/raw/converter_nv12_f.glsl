#version 100

precision mediump float;

uniform sampler2D tex;
uniform sampler2D uvTex;

varying vec2 v_texCoord;

void main(void) {

    float r, g, b, y, u, v;


    y = texture2D(tex, v_texCoord).r;
    vec2 uv = texture2D(uvTex, v_texCoord).ra;
    u = uv.x - .5;
    v = uv.y - .5;

    r = y + 1.13983 * v;
    g = y - 0.39465 * u - 0.58060 * v;
    b = y + 2.03211 * u;

    gl_FragColor = vec4(r, g, b, 1.);
}