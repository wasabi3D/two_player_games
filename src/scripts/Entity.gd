extends KinematicBody2D


export var health: int
var _velocity: Vector2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _physics_process(delta: float) -> void:
	_velocity = move_and_slide(_velocity)
