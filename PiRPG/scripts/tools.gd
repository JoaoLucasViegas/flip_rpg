extends Node

enum states {IDLE, WALK}

# ORIGINAL
# Cool function to cut the work of doing it manually. Also notice I'm using it
# just to generate a string. Whatever the way you use it, you must make sure it
# will work. For example, on the original source code, there was an enemy that was having
# problems with animation cause the name of animation didn't existed/was missing
# on it's implementation.
#
# PLAYER SCRIPT COMMENT
# Same code. I actually think I'll make a "tool class" just for these kind of codes.
# It's reusable and it's been repeated.
# But since this code is literally a copy+paste from the enemyBase, I didn't bothered.
# It's for the sake of reimplementing movement, this thing is just a tool really.
func get_animation_string(state, direction: Vector2) -> String:
	var string = "idle_"
	if state == states.WALK:
		string = "walk_"

	match direction:
		Vector2.LEFT:
			string += "left"
		Vector2.RIGHT:
			string += "right"
		Vector2.UP:
			string += "up"
		Vector2.DOWN:
			string += "down"

	return string

# That's an shortcut function I made for the script. This is also
# good for a Tool class later on.
#
# OVERVIEW COMMENT
# This function was created since I was repeating myself on the same logic
# but since this code is useful for both Player and Mobs, I used it on both
# and it made me realize it should be put here on "Tools" function.
# Instead of try-catch every animation on every entity, why not try it for all
# cases in 1 simple script: Tools?! That's why it exists and why it's here.
func try_animation(anim_sprite: AnimatedSprite2D, anim_name: String):
	var spriteframes = anim_sprite.sprite_frames
	if spriteframes.has_animation(anim_name):
		anim_sprite.play(anim_name)

# Helper function to turn (0.7, -0.7) into (0, -1) for the animator
# Got that from AI but still, that's the same as pick a rand function from the
# Godot lib like PI, rand and so on.
#
# Purpose of this function is to return a set of vectors so I can filter them
# before I can actually use on "get_anim_string"; So instead of fighting against
# the code, I filter the vector and then send those (this filtered version) to
# my use-case, being the "get_anim_string".
func snap_to_cardinal_priority(new_vec: Vector2, old_vec: Vector2) -> Vector2:
	# If we are already moving in a direction and that key is still held, 
	# don't switch the animation to the other axis unless the other axis is much stronger.
	
	# 1. Check if the old direction is still present in the new input
	# (e.g. if we were going LEFT, is new_vec.x still negative?)
	var still_holding_old = false
	if old_vec == Vector2.LEFT and new_vec.x < 0: still_holding_old = true
	if old_vec == Vector2.RIGHT and new_vec.x > 0: still_holding_old = true
	if old_vec == Vector2.UP and new_vec.y < 0: still_holding_old = true
	if old_vec == Vector2.DOWN and new_vec.y > 0: still_holding_old = true
	
	# 2. If we are still holding the original direction, keep that sprite.
	if still_holding_old:
		return old_vec
		
	# 3. If we aren't holding the old one, or it's a fresh press, 
	# fall back to the basic snapping.
	if abs(new_vec.x) > abs(new_vec.y):
		return Vector2.RIGHT if new_vec.x > 0 else Vector2.LEFT
	else:
		return Vector2.DOWN if new_vec.y > 0 else Vector2.UP
