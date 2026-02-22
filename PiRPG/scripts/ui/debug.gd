extends Control

@onready var label_list = $VBoxContainer
@onready var toggle_btn = $HideDebugButton

func _enter_tree() -> void:
	if not OS.has_feature("debug"):
		queue_free()


func _unhandled_key_input(_event: InputEvent) -> void:
	if Input.is_key_label_pressed(KEY_U):
		_toggle_debug()

func _toggle_debug() -> void:
	label_list.visible = not label_list.visible
	toggle_btn.text = "Hide Debug" if label_list.visible else "Show Debug"


func _on_hide_debug_button_pressed() -> void:
	_toggle_debug()
