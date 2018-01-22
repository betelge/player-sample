#version 100

precision mediump float;

varying vec2 uvCoord;

uniform vec3 u_angles; // (hori angle (1=360), vert angle (1=180), verticalCrop)
uniform sampler2D frame;

vec4 equirectangular(sampler2D sampler, vec2 uv)
{
	uv -= vec2(.5);
	uv /= u_angles.xy;
	uv += vec2(.5);

	// Crop
	uv.y -= .5;
	uv.y *= u_angles.z;
	uv.y += .5;

	return texture2D(sampler, uv);
}

void main(void) {
    gl_FragColor = equirectangular(frame, uvCoord);
}