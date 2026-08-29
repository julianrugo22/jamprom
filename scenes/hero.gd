extends CharacterBody2D

@export var animation: Node
@onready var dash_timer = $Timer

var _momentum: float = 0
var _dash_state = false
var _dash_charged = false

func _normal_movement(_direction,delta):
	var _instant_acceleration = 0 
	var _instant_decceleration = 0
	
	for i in range(len(Param.BREAKPOINT_SPEEDS)):
		if Param.BREAKPOINT_SPEEDS[i] > _momentum:
			continue
		_instant_acceleration = Param.INSTANT_ACCELERATION[i]
		_instant_decceleration = Param.INSTANT_DECCELERATION[i]
		break
		
		
	if _direction.length() == 0:
		_momentum -= _instant_decceleration * delta
	elif velocity.dot(_direction) >= 0:
		_momentum += _instant_acceleration * delta
		if _momentum < Param.STARTING_MOMENTUM:
			_momentum = Param.STARTING_MOMENTUM

	_momentum = clamp(_momentum, 0, Param.MAX_MOMENTUM)

	velocity = _momentum * _direction
func _movement_while_charging(_momentum,delta):
	
	return
	
	
# Fisica y controles
func _dash_attack(_direction, delta):
	
	_dash_state = false
	
	
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
	if Input.is_action_just_pressed("Dash_attack"):
		_dash_state = true
		dash_timer.start()
	if Input.is_action_just_released("Dash_attack"):
		_dash_attack(_momentum,delta)
	_direction = _direction.normalized()
	if !(_dash_state):
		_normal_movement(_direction,delta)
		_dash_state = false
	else:
		_movement_while_charging(_momentum, delta)


	move_and_slide()

# Graficos 

var _radius =  Param.STARTING_MOMENTUM * Param.MOMENTUM_RADIUS_CONVERSION

func _process(delta: float) -> void:
	_radius = clamp(_momentum * Param.MOMENTUM_RADIUS_CONVERSION, Param.STARTING_MOMENTUM * Param.MOMENTUM_RADIUS_CONVERSION, Param.MAX_RADIUS)

	animation.play("run")
	
	queue_redraw()
	
	

func _draw():
	draw_circle(Vector2.ZERO, _radius, Color.ORANGE)


func _on_timer_timeout() -> void:
	_dash_charged = true
