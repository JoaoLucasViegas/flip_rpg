class_name FireballAttack extends Area2D

# General variables
@export var projectile_speed: int = 80
@export var lifetime: float = 1.5

var damage_amount = 20.0

var direction := Vector2.ZERO

func _ready() -> void:
	# Delete the fire ball when lasting too long.
	get_tree().create_timer(lifetime).timeout.connect(queue_free)

func setup(g_position: Vector2, _direction: Vector2, _lifetime: float, _speed: int, coll_layer: int, coll_mask: int):
	self.global_position = g_position
	self.direction = _direction
	self.lifetime = _lifetime
	self.projectile_speed = _speed
	rotation = self.direction.angle()
	collision_layer += coll_layer
	collision_mask += coll_mask

func _process(delta: float) -> void:
	position += direction * projectile_speed * delta # Move the projectile in the direction is facing
	if position.x < -100 or position.x > 2000:
		queue_free() # If it gets out of the screen, destroy it.

func _on_area_entered(area: Area2D) -> void:
	# Here we'll manage if the fireball hit and enemy or another object!
	if area is Health:
		area.damage(damage_amount)
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if not body is EnemyBase:
		queue_free()
