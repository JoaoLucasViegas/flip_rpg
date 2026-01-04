class_name CombatManager extends Node2D

enum parent_type {
	PLAYER, NPC
}
@export var controller_type: parent_type
var parent = null
# |----- Disclaimer -------
# | I was trying to fix the previous implementation of the mobs/enemies but
# | ended up realizing it was "smarter" by remaking them instead of fix each 
# | part that was meant to be modular.
# | 
# | This is just a part of a code you might see later on in production. For now
# | it's just a sample for combats/attacks.
# | 
# | I tried fixing stuff so this was my first "implementation".
# | It might be used later on, just let us "fix" the movement and player recognition
# | on enemies/mobs or else it will be too "specific just for mobs.
# | 
# | This code is meant for modular purposes, so instead of making 1 source code
# | for each mob/entity on the game, make it all here and each element has it's own
# | use of this.
# | 
# | All the rest might be the same code I picked before.
# | ---------------------


# Fireball scene
var fireball_scene = preload("res://scripts/combat/projectile/fireball.tscn")

func _ready() -> void:
	if controller_type == parent_type.PLAYER:
		parent = get_parent() as Player2
	
	print(parent)

func _physics_process(_delta: float) -> void:
	if controller_type == parent_type.PLAYER:
		if Input.is_action_just_pressed("shoot"):
			#var _parent = get_parent() as Player
			#shoot_fireball(_parent.picked_direction)
			
			shoot_fireball(
				global_position.direction_to(get_global_mouse_position())
			)

# -----------------------------
# Shoot a fireball in the movement direction
# -----------------------------
func shoot_fireball(target_direction: Vector2) -> void:
	# Only shoot if the mob has a valid movement direction
	#if last_input_vector == Vector2.ZERO:
		#return

	# Instantiate fireball
	#var fireball = fireball_scene.instantiate()
	#fireball.global_position = global_position + last_input_vector.normalized()
	#fireball.direction = last_input_vector
	#fireball.rotation = last_input_vector.angle()
	#get_tree().current_scene.add_child(fireball)
	var fireball = fireball_scene.instantiate() as FireballAttack
	fireball.setup(global_position, target_direction, 1.5, 120, parent.collision_layer, parent.collision_mask)
	get_tree().current_scene.add_child(fireball)
