extends CharacterBody2D

@export var animation: Node
@onready var _charge_timer = $Charge_Timer
@onready var _dash_timer = $Dash_Timer
signal request_tracking

var _momentum: float = 0
var _is_dashing = false
var _dash_charged = false
var _dash_direction:Vector2 = Vector2(0,0)
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
	var _penalty = 1
	if Input.is_action_pressed("Dash_attack"):
		_penalty = 0.4
	velocity = _momentum * _direction * _penalty

	
	
# Fisica y controles
func _dash_attack(dash_direction):
	velocity = dash_direction * Param.DASH_SPEED
	
	
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
	if Input.is_action_just_pressed("Dash_attack"):
		_dash_charged = false
		_charge_timer.start(Param.CHARGING_TIMER)
	if Input.is_action_just_released("Dash_attack"):
		if _dash_charged:
			_is_dashing = true
			_dash_direction = _direction
			_dash_timer.start(Param.DASH_TIMER)
			

	if _is_dashing:
		_dash_attack(_dash_direction)
		
	else:
		_normal_movement(_direction,delta)
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




func _on_dash_timer_timeout() -> void:
	_is_dashing = false
