class_name Health extends Area2D

@onready var progress_bar = $ProgressBar
@onready var health_timer = $Timer

@export var health_max: float = 100.0
@export var show_health_bar: bool = false

@onready var health_power = health_max
var is_dying = false

func _ready() -> void:
	if get_parent() as CollisionObject2D:
		collision_layer += get_parent().collision_layer
		collision_mask += get_parent().collision_mask
	_update_progress_bar(1.0)
	progress_bar.hide()

func _physics_process(_delta: float) -> void:
	if show_health_bar:
		progress_bar.show()
		progress_bar.show_percentage = true

func _update_progress_bar(step: float):
	progress_bar.max_value = abs(health_power - health_max)
	progress_bar.value = health_power
	progress_bar.step = step/health_power

func damage(amount: float) -> void:
	if is_dying:
		return
	if health_power - amount > 0:
		health_power -= amount
		health_timer.start()
		_update_progress_bar(amount)#health_power/amount)
		progress_bar.show()
		return
	is_dying = true
	_kill_parent()

func _kill_parent():
	if get_parent().has_method("kill"):
		get_parent().kill()

func _on_timer_timeout() -> void:
	progress_bar.hide()
