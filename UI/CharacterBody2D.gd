extends CharacterBody2D

var speed = 15

func _physics_process(delta: float) -> void:
	
	var dir = Vector2.ZERO
	
	if Input.is_action_pressed("ui_up"):
		dir.y -= 1
	if Input.is_action_pressed("ui_down"):
		dir.y += 1
	if Input.is_action_pressed("ui_left"):
		dir.x -= 1
	if Input.is_action_pressed("ui_right"):
		dir.x += 1
		
	if dir != Vector2.ZERO:
		dir = dir.normalized()
		position += dir*speed
