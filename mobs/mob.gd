extends CharacterBody3D

var speed_min = 5
var speed_max = 8
var hit_point = 1
var hit_power = 5

signal squashed

func _physics_process(delta: float) -> void:
	move_and_slide()


func initialize(start_position: Vector3, player_position: Vector3) -> void:
	
	look_at_from_position(start_position,player_position)
	rotate_y(randf_range(-PI/4,PI/4))
	
	var rand_speed = randi_range(speed_min,speed_max)
	
	velocity = Vector3.FORWARD * rand_speed
	velocity = velocity.rotated(Vector3.UP,rotation.y)
	
	$AnimationPlayer.speed_scale = rand_speed/speed_min


func _on_visible_on_screen_notifier_3d_screen_exited() -> void:
	queue_free()

func squash():
	squashed.emit()
	queue_free()
