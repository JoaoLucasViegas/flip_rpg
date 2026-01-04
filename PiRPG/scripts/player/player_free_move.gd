class_name Player2 extends CharacterBody2D

const speed = 5

enum states {IDLE, WALK}
var state = states.IDLE
var picked_direction = Vector2.DOWN

@onready var tile_size = Global.TILE_SIZE
@onready var anim_sprite = $AnimatedSprite2D


func _physics_process(_delta: float) -> void:
	
	var input_vector = Vector2(
		Input.get_axis("player_mv_left", "player_mv_right"),
		-Input.get_axis("player_mv_down", "player_mv_up")
	)
	
	if input_vector != Vector2.ZERO:
		state = states.WALK
		picked_direction = Tools.snap_to_cardinal_priority(input_vector, picked_direction)
	else:
		state = states.IDLE
	
	velocity = input_vector.normalized() * speed * tile_size
	
	if velocity.length() < speed:
		state = states.IDLE
	Tools.try_animation(anim_sprite, Tools.get_animation_string(state, picked_direction))
	
	move_and_slide()
