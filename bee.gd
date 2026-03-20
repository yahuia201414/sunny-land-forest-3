
extends Area2D
var max_health = 3
@onready var animated_sprite_2d_2 = $AnimatedSprite2D2





func _on_top_body_entered(body):
	if body.has_method("die"):
		body.die()
# Replace with function body.


func _on_body_entered(body):
	if body.is_in_group("player"):
		max_health -= 1
		if body.has_method("bounce"):
			body.bounce()
# Replace with function body.
	if max_health > -1 and max_health < 1:
		queue_free()
		if body.has_method("bounce"):
			body.bounce()
	if max_health > 2 and max_health < 4:
		animated_sprite_2d_2.play("default")
	if max_health > 1 and max_health < 3:
		animated_sprite_2d_2.play("new_animation")
	if max_health > 0 and max_health < 2:
		animated_sprite_2d_2.play("new_animation_1")
	if max_health > -1 and max_health < 1:
		animated_sprite_2d_2.play("new_animation_2")
