extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_more_games_button_pressed() -> void:
	OS.shell_open("https://lifenture.itch.io/")


func _on_edu_button_pressed() -> void:
	OS.shell_open("https://bsky.app/profile/edusilvart.bsky.social")


func _on_wigner_button_pressed() -> void:
	OS.shell_open("https://x.com/Wigner_Matos")
