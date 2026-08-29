extends Camera2D

@onready var timer = get_children()[0]

var _deviation = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position = _deviation
	_deviation = Vector2(0,0)

func _on_hero_request_tracking() -> void:
	_deviation = get_parent().velocity * 1/2

func _on_timer_timeout() -> void:
	print("a")
