extends Node2D
class_name SpriteStack

# @export aparece dentro do editor
@export var texture : Texture = null
@export var num_slices : int = 1 # numero de camadas no sprite

# rotação dos sprites. tem que mudar a rotação dos spritestack aqui, pra dar o efeito 3D
var rot = 0

func _ready() -> void:
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
	var children = get_children()
	
	# atualiza a rotação de cada sprite no próprio pivot pra dar o efeito 3D
	for i in children.size():
		children[i].rotation = rot
		children[i].z_index = position.y
	
	@warning_ignore("narrowing_conversion")
	z_index = -position.dot(Vector2())
