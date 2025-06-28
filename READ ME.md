CAMEL CASE
variáveis: camel_case
arquivos: camel_case
nodes/classes: CamelCase
inputs: 'Camel_Case'

PASTAS

a godot recomenda guardar por contexto e não por tipo
ou seja, ao invés de ter as pastas: scripts, sprites, sounds...
você tem: player >
		player_script
		player_sprite
		player_sound...

algumas pastas que criei
prototype: pra jogar aquelas coisas que a gente vai deletar depois
utilities: alguns scripts e outras coisas necessárias
scenes: isso é de cenas mesmo (como main menu, jogo, tela de créditos) e não de .tscn. não sabia que nome colocar talvez seja melhor trocar depois pq fica confuso

-------------------

todos os nodes na godot são classes
cada script começa com: extends class
significa que aquele script ta vindo dessa classe, você pode reusar tudo daquela classe nesse novo script
se você declarar a mesma função, ela vai ser trocada por essa nova
dá uma pesquisada pq eu programo tudo assim

os carros são a classe: Car
spritestacks classe: SpriteStack
