extends Node2D

var monster = preload("monster.tscn")
var bullet = preload("bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var new_monster = monster.instantiate()
	new_monster.fired.connect(_on_monster_fired)
	
	new_monster.position = Vector2(100, 50)
	add_child(new_monster)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_monster_fired(pos, vel):
		var new_bullet = bullet.instantiate()
		new_bullet.position = pos
		new_bullet.velocity = vel
		
		add_child(new_bullet)
