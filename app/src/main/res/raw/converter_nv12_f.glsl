#version 100

precision mediump float;

uniform sampler2D tex;
uniform vec2 u_cropRatio; // (ratio, width)

varying vec2 v_texCoord;

void main(void) {

    float r, g, b, y, u, v;

    vec2 cropCoord = vec2(1., u_cropRatio.x) * (v_texCoord - vec2(.5)) + vec2(.5);

    float width = u_cropRatio.y;

    vec4 yyyy = texture2D(tex, vec2(1., .5) * cropCoord);

    float f = v_texCoord.x * width - 4. * floor(v_texCoord.x * width / 4.);
    if(f < 1.)
        y = yyyy.r;
    else if(f < 2.)
        y = yyyy.g;
    else if(f < 3.)
        y = yyyy.b;
    else
        y = yyyy.a;

    vec4 uv = texture2D(tex, vec2(1., .25) * cropCoord + vec2(0., .5));

    if(f < 2.) {
        u = uv.r;
        v = uv.g;
    }
    else {
        u = uv.b;
        v = uv.a;
    }

    y = 1.1643 * (y - 0.0625);
    u = u - 0.5;
    v = v - 0.5;

    r = y + 1.5958 * v;
    g = y - 0.39173 * u - 0.81290 * v;
    b = y + 2.017 * u;

    gl_FragColor = vec4(r, g, b, 1.);
}