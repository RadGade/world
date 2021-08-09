shader_type spatial;
render_mode blend_mix,depth_draw_opaque,cull_back,diffuse_burley,specular_schlick_ggx;
uniform vec4 albedo : hint_color;
uniform sampler2D texture_albedo : hint_albedo;
uniform float specular;
uniform float metallic;
uniform float roughness : hint_range(0,1);
uniform float point_size : hint_range(0,128);
uniform vec3 uv1_scale;
uniform vec3 uv1_offset;
uniform vec3 uv2_scale;
uniform vec3 uv2_offset;

uniform vec4 sandColor : hint_color = vec4(0.9,0.9, 0.6, 1.0);
uniform vec4 grassColor :hint_color = vec4(0.5, 1.0, 0.3, 1.6);

varying flat vec3 out_color; 

vec3 lerpColor(vec4 a, vec4 b, float t){
	float rr = a.r + (b.r - a.r) * t;
	float gg = a.g + (b.g - a.g) * t;
	float bb = a.b + (b.b - a.b) * t;
	return vec3(rr, gg, bb);
}

void vertex() {
	UV=UV*uv1_scale.xy+uv1_offset.xy;
	
	out_color = vec3(sandColor.r, sandColor.g, sandColor.b);
	
	if(VERTEX.y > 0.0){
		out_color = lerpColor(sandColor, grassColor, clamp((VERTEX.y)/3.0, 0.0, 1.0));
	}
}

void fragment() {
	vec2 base_uv = UV;
	vec4 albedo_tex = texture(texture_albedo,base_uv);
	ALBEDO = albedo.rgb * albedo_tex.rgb;
	METALLIC = metallic;
	ROUGHNESS = roughness;
	SPECULAR = specular;
}
