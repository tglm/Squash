extends CharacterBody3D

@export var speed = 12
@export var fall_acceleration = 75
@export var jump_impulse = 25
@export var bounce_impulse = 30

var hp_max: int = 5
var hp_current: int = 3

signal hit(hp_current: int, hp_max: int)
signal dead
signal exit_screen
signal enter_screen

var target_velocity = Vector3.ZERO

func _ready() -> void:
	emit_hit_signal()


func _physics_process(delta: float) -> void:
	
	var dir = Vector3.ZERO
	
	if Input.is_action_pressed("ui_up"):
		dir.z -= 1
	if Input.is_action_pressed("ui_down"):
		dir.z += 1
	if Input.is_action_pressed("ui_left"):
		dir.x -= 1
	if Input.is_action_pressed("ui_right"):
		dir.x += 1
		
	if dir != Vector3.ZERO:
		dir = dir.normalized()
		$Pivot.look_at(position+dir)
		
	target_velocity.x = speed * dir.x 
	target_velocity.z = speed * dir.z 
	
	#  For the vertical velocity, we subtract the fall acceleration
	#  multiplied by the delta time every frame. 
	#  This line of code will cause our character to fall in every frame,
	#  as long as it is not on or colliding with the floor.
	
	if not is_on_floor() :
		target_velocity.y -= fall_acceleration * delta
	
	if is_on_floor() and Input.is_action_pressed("ui_jump"):
		target_velocity.y = jump_impulse
		
	#获取碰撞对象
	for i in get_slide_collision_count():
		var collision  = get_slide_collision(i)
		
		if collision.get_collider() == null:
			continue
		if collision.get_collider().is_in_group("mob"):
			var mob = collision.get_collider()
			
			#计算是否踩到
			if Vector3.UP.dot(collision.get_normal()) > 0.1:
				mob.squash()
				target_velocity.y = bounce_impulse
			
	#移动时动画加速
	if dir != Vector3.ZERO:
		$AnimationPlayer.speed_scale = 4
	else:
		$AnimationPlayer.speed_scale = 1
	
	velocity = target_velocity
	move_and_slide()
	

	
	#ss
	$Pivot.rotation.x = PI / 6 * velocity.y / jump_impulse

func _on_mob_detector_body_entered(body: Node3D) -> void:
	
	if body.is_in_group("mob"):
		get_hit(body)
		


func get_hit(mob: CharacterBody3D) -> void:
	hp_current -= mob.hit_point
	hit_back(mob)
	if hp_current > 0:
		emit_hit_signal()
	else:
		die()

#fixme
func hit_back(attacker: CharacterBody3D):
	var dir = (attacker.position - self.position).normalized()
	velocity = attacker.hit_power * dir
	move_and_slide()
	
	
func die() -> void:
	dead.emit()
	$"/root/MusicPlayer".stop()
	queue_free()


func _on_visible_on_screen_notifier_3d_screen_exited() -> void:
	exit_screen.emit()

func _on_visible_on_screen_notifier_3d_screen_entered() -> void:
	enter_screen.emit()
	
func emit_hit_signal() -> void:
	hit.emit(hp_current, hp_max)
