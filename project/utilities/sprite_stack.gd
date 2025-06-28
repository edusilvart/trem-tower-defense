@tool
extends Node2D
class_name SpriteStack


# @export aparece dentro do editor
@export var texture : Texture = null
@export var num_slices : int = 1 # numero de camadas no sprite

@export var build : bool = false # constroe o sprite stack no editor
@export var spin : bool = false # gira o sprite no editor

# rotação dos sprites. tem que mudar a rotação dos spritestack aqui, pra dar o efeito 3D
var rot = 0

func _ready() -> void:
	build_sprite()

func build_sprite():
	build = false
	
	if texture != null:
		if get_child_count() > 0:
			for c in get_children():
				c.queue_free()
		
		# define largura e altura de cada camada do sprite
		var w = texture.get_width()/num_slices
		var h = texture.get_height()

		# pra cada camada, cria um novo sprite e adiciona como child desse mesmo node
		for i in range(0, num_slices):
			var slice = Sprite2D.new()
			slice.texture = texture
			slice.region_enabled = true
			slice.region_rect = Rect2(i*w, 0, w, h)
			
			# posiciona exatamente 1px acima da outra pra dar o efeito 3D
			slice.position = Vector2(0, -i)
			
			add_child(slice)

func _process(_delta) -> void:
	if Engine.is_editor_hint():
		if build:
			build_sprite()
		if spin:
			rot += 0.001
		else:
			if rot != 0:
				rot = 0
	
	var children = get_children()
	
	# atualiza a rotação de cada sprite no próprio pivot pra dar o efeito 3D
	for i in children.size():
		children[i].rotation = rot
		children[i].z_index = position.y
	
	@warning_ignore("narrowing_conversion")
	z_index = -position.dot(Vector2())
