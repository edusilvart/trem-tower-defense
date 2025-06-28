extends CharacterBody2D
class_name Car


@onready var sprite : SpriteStack = get_node('SpriteStack') # ref do node do sprite stack

var speed : float = 0.0 # velocidade atual
var max_speed : float = 200.0 # velocidade máxima
var acceleration : float = 200.0 # aceleração do carro
var slow_down : float = 200.0 # desaceleração
var brake : float = 100.0 # força do freio
var direction : float = 0.0 # angulo que tá se dirigindo (em degrees)
var steer_speed : float = 100.0

func _ready() -> void:
	motion_mode = MOTION_MODE_FLOATING # isso aqui coloca o CharcterBody2D no modo top down, sem gravidade etc

# separado pq o player chama a aceleração e o freio com os inputs enquanto os outros carros chamam com a logica do contexto mesmo
func steer(steer_dir : float, delta : float) -> void: # manobrar pros lados
	if velocity.length() >= 0.1: # isso evita de virar o carro parado
		direction += steer_dir * steer_speed * delta
	
	sprite.rot = deg_to_rad(direction) # rotaciona os sprites com a direção
	move_and_slide() # isso aqui que faz a godot calcular o movimento e colisão

func accelerate(power : float, delta : float) -> void: # acelera o carro. power: 0 = desacelera || 1 = acelera
	if power > 0: # move toward é uma interpolação de float. nesse caso se o carro tiver acelerando ele interpola com o "acceleration" senão, ele interpola com o "slow_down"
		speed = move_toward(speed, power * max_speed, acceleration * delta) # acelerando
	else:
		speed = move_toward(speed, 0, slow_down * delta) # desacelerando
	
	velocity = Vector2(speed, 0) # adiciona velocidade na direita
	velocity = velocity.rotated(deg_to_rad(direction)) # rotaciona a velocidade no angulo da direção

func stop(delta : float) -> void: # freio
	velocity = velocity.move_toward(Vector2.ZERO, slow_down * delta)
