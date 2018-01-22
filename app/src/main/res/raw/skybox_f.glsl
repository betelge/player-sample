#version 100

precision mediump float;

varying vec2 uvCoord;

uniform vec3 u_angles; // (hori angle (1=360), vert angle (1=180), verticalCrop)
uniform sampler2D frame;

void main(void) {
    vec2 uv = uvCoord;

    // Crop
    uv.y -= .5;
    uv.y *= u_angles.z;
    uv.y += .5;

    gl_FragColor = texture2D(sampler, uv);
}