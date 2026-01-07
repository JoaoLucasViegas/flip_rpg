extends AnimatedSprite2D

var is_dead = false

func _physics_process(delta: float) -> void:
	
	if not is_dead:
		modulate.a = move_toward(modulate.a, 0.0, delta * delta * PI)
	
	if modulate.a == 0.0:
		is_dead = true
		queue_free()
