class_name EnemyScanner extends Area2D

var last_scan_pos = Vector2.ZERO
var available_enemy: Node2D = null

func _physics_process(_delta: float) -> void:
	last_scan_pos = global_position
	global_position = get_global_mouse_position()
	
	if has_overlapping_bodies():
		for enemy in get_overlapping_bodies():
			if enemy.is_queued_for_deletion():
				available_enemy = null
				break
			else:
				available_enemy = enemy
	else:
		available_enemy = null
