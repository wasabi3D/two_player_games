extends "res://src/scripts/Entity.gd"


export var acceleration: float
export var angular_accel: float
export var break_intensity: float
export var speed_limit: float
export var player_1: bool

onready var bullet = preload("res://src/actors/Bullet.tscn")

var a = true

func _process(delta: float) -> void:
	if Input.get_action_strength("pl1_shoot" if player_1 else "pl2_shoot") and a:
		shoot()
		a = false



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var mov: Vector2 = get_movement()
	rotation_degrees += mov.y * angular_accel * delta

	_velocity += get_global_transform().basis_xform(Vector2.UP).normalized() * acceleration * delta * mov.x
	_velocity -= _velocity * break_intensity * delta


func get_movement() -> Vector2:
	var intensity_engine: float
	var intensity_rot: float
	if player_1:
		intensity_engine = Input.get_action_strength("pl1_moveup") - Input.get_action_strength("pl1_movedown")
		intensity_rot = Input.get_action_strength("pl1_moveright") - Input.get_action_strength("pl1_moveleft")
	else:
		intensity_engine = Input.get_action_strength("pl2_moveup") - Input.get_action_strength("pl2_movedown")
		intensity_rot = Input.get_action_strength("pl2_moveright") - Input.get_action_strength("pl2_moveleft")
	return Vector2(intensity_engine, intensity_rot)


func shoot() -> void:
	print("shoot")
	var bul = bullet.instance()
	# add_child_below_node(get_node("TankSprite"), bul)
	get_node("BulletSpawnPoint").add_child(bul)
	print(get_node("BulletSpawnPoint").name)
	
