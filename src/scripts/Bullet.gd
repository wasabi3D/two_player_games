extends KinematicBody2D


export var bullet_speed: float
export var bounce_lim: int

var _velocity: Vector2



func _ready() -> void:
	_velocity = get_parent().get_parent().get_global_transform().basis_xform(Vector2.UP).normalized() * bullet_speed
	var pos = global_position
	var rot = get_parent().get_parent().global_rotation
	var new_parent = get_node("/root/TankGame")
	get_parent().remove_child(self)
	new_parent.add_child(self)
	position = pos
	rotation = rot


func _physics_process(delta: float) -> void:
	var col: = move_and_collide(_velocity * delta)
	if col:
		reflect(col)


func reflect(collision: KinematicCollision2D) -> void:
	print(collision.normal)
	print("aaa")
	#var motion = collision.remainder.bounce(collision.normal)
	_velocity = _velocity.reflect(collision.normal.rotated(PI / 2))
	#move_and_collide(motion)
	look_at(position + _velocity)
	rotation_degrees += 90
