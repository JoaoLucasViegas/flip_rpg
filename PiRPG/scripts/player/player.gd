class_name Player extends CharacterBody2D

enum states {IDLE, WALK}
var state = states.IDLE
var picked_direction = Vector2.DOWN

@onready var tile_size = Global.TILE_SIZE
@onready var animation_sprite = $AnimatedSprite2D

@onready var death_sprite = preload("res://prefabs/effects/dead_sprite.tscn")

func kill():
	#Global.add_child(get_viewport().get_camera_2d())
	get_viewport().get_camera_2d().reparent(Global)
	var dead: AnimatedSprite2D = death_sprite.instantiate()
	dead.global_position = global_position
	get_tree().get_nodes_in_group("trash").front().add_child(dead)
	queue_free()
