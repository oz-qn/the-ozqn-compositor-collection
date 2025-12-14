#[compute]
#version 450

layout(local_size_x = 8, local_size_y = 8, local_size_z = 1) in;

layout(rgba16f, set = 0, binding = 0) uniform image2D color_image;

layout(push_constant, std430) uniform Params {
	float gamma;
};

void main() {
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    vec4 color = imageLoad(color_image, coord);
    color = pow(color, vec4(1.0f / gamma));
    imageStore(color_image, coord, color);
}