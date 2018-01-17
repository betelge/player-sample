#version 100

precision mediump float;

uniform sampler2D tex;
uniform float u_cropRatio;

varying vec2 v_texCoord;

void main(void) {

    float r, g, b, y, u, v;

    vec2 cropCoord = vec2(1., u_cropRatio) * (v_texCoord - vec2(.5)) + vec2(.5);

    vec4 yyyy = texture2D(tex, vec2(1., .5) * cropCoord);

    float f = mod(gl_FragCoord.x, 4.);
    if(f < 1.)
            gl_FragColor = vec4(0., 1., 0., 1.);
    else if(f < 2.)
            gl_FragColor = vec4(1., 0., 0., 1.);
    else if(f < 3.)
            gl_FragColor = vec4(1.);
    else
            gl_FragColor = vec4(0., 0., 1., 1.);

            return;

    vec4 uv = texture2D(tex, vec2(1., .25) * cropCoord + vec2(0., .5));

    if(f < 2.) {
        u = uv.r;
        v = uv.g;
        gl_FragColor = vec4(1.);
        return;
    }
    else {
        u = uv.b;
        v = uv.a;
        gl_FragColor = vec4(0.);
        return;
    }

    y = 1.1643 * (y - 0.0625);
    u = u - 0.5;
    v = v - 0.5;

    r = y + 1.5958 * v;
    g = y - 0.39173 * u - 0.81290 * v;
    b = y + 2.017 * u;

    gl_FragColor = vec4(r, g, b, 1.);
}