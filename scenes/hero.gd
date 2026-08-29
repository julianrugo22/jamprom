extends CharacterBody2D

@export var animation: Node

var _momentum: float = 0

# Fisica y controles
func _physics_process(delta: float) -> void:
	
	var _direction: Vector2 = Vector2(0,0)
	if Input.is_action_pressed("ui_right"):
		_direction += Vector2(1,0)
	
	if Input.is_action_pressed("ui_left"):
		_direction += Vector2(-1,0)
		
	if Input.is_action_pressed("ui_up"):
		_direction += Vector2(0,-1)
		
	if Input.is_action_pressed("ui_down"):
		_direction += Vector2(0,1)
		
	_direction = _direction.normalized()
	
	if _direction.length() == 0:
		_momentum -= Param.DECCELERATION * delta
	elif velocity.dot(_direction) >= 0:
		_momentum += Param.ACCELERATION * delta
		
		if _momentum < Param.STARTING_MOMENTUM:
			_momentum = Param.STARTING_MOMENTUM

	_momentum = clamp(_momentum, 0, Param.MAX_MOMENTUM)

	velocity = _momentum * _direction

	move_and_slide()

# Graficos 

var _radius = Param.MIN_RADIUS

func _process(delta: float) -> void:
	_radius = clamp(_momentum, Param.MIN_RADIUS, Param.MAX_RADIUS)
	
	animation.play("run")
	
	queue_redraw()
	
	

func _draw():
	draw_circle(Vector2.ZERO, _radius, Color.ORANGE)
