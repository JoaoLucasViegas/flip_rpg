class_name PlayerScanner extends Area2D

@export var combat_manager: CombatManager = null

var is_player_on_scan = false
var last_scan_pos = Vector2.ZERO
var available_player: Node2D = null
@onready var shoot_timer: SceneTreeTimer = get_tree().create_timer(0.02)

func _ready() -> void:
	if combat_manager == null:
		printerr("Forgot to add combat manager on ", name, " node at ", get_tree().current_scene.find_child(name))
		get_tree().quit()

func _physics_process(_delta: float) -> void:
	#var near_player = get_tree().get_nodes_in_group("player").front()
	last_scan_pos = global_position
	
	if has_overlapping_bodies() and not shoot_timer.time_left:
		for player in get_overlapping_bodies():
			if player.is_queued_for_deletion():
				available_player = null
				break
			else:
				available_player = player
				combat_manager.shoot_fireball(
					global_position.direction_to(available_player.global_position)
				)
				shoot_timer = get_tree().create_timer(randf_range(0.5, 1.5))
	else:
		available_player = null
