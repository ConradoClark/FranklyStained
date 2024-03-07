shader_type canvas_item;

uniform vec4 color1 : source_color = vec4(1.0);
uniform float width1 : hint_range(0, 2) = 1.0;
uniform vec4 color2 : source_color = vec4(1.0);
uniform float width2 : hint_range(0, 2) = 1.0;
uniform sampler2D screen_texture : hint_screen_texture;

// this looks so unoptimized, but oh well
void fragment() {
  vec2 uv = UV;
  vec4 tex_color = texture(screen_texture, SCREEN_UV);
	vec2 size1 = SCREEN_PIXEL_SIZE * width1;
  vec2 size2 = SCREEN_PIXEL_SIZE * width2;

  float outline = texture(screen_texture, SCREEN_UV + vec2(-size1.x, 0)).a;
  outline += texture(screen_texture, SCREEN_UV + vec2(0, size1.y)).a;
  outline += texture(screen_texture, SCREEN_UV + vec2(size1.x, 0)).a;
  outline += texture(screen_texture, SCREEN_UV + vec2(0, -size1.y)).a;
  outline = min(outline, 1.0);
  
  float outline2 = texture(screen_texture, SCREEN_UV + vec2(-size2.x-size1.x, 0)).a;
  outline2 += texture(screen_texture, SCREEN_UV + vec2(0, size2.y + size1.y)).a;
  outline2 += texture(screen_texture, SCREEN_UV + vec2(size2.x + size1.x, 0)).a;
  outline2 += texture(screen_texture, SCREEN_UV + vec2(0, -size2.y-size1.y)).a; 
  
  // diagonals for external
  outline2 += texture(screen_texture, SCREEN_UV + vec2(-size2.x, -size2.y)).a;
  outline2 += texture(screen_texture, SCREEN_UV + vec2(-size2.x, +size2.y)).a;
  outline2 += texture(screen_texture, SCREEN_UV + vec2(size2.x, -size2.y)).a;
  outline2 += texture(screen_texture, SCREEN_UV + vec2(size2.x, +size2.y)).a;
  outline2 = min(outline2, 1.0);
  
  // Get the texture from the screen
  vec4 tex = texture(screen_texture,SCREEN_UV);
  vec4 modulate = COLOR - vec4(1, 1, 1, 0);
  vec4 tex1 = mix(tex, color1 + modulate, outline - tex.a);
  vec4 tex2 = mix(tex, color2 + modulate, outline2 - tex.a);
  COLOR = mix(tex1,tex2, outline2-outline);
}