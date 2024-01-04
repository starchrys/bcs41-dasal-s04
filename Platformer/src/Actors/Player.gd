extends Actor

var isDead = false
var life = 1

onready var mc_idle: AnimatedSprite = $McIdle
onready var bounce_raycasts: Node2D = $BounceRaycasts
onready var player: KinematicBody2D = $"."

func _physics_process(delta: float) -> void:
	if (velocity.x > 1 || velocity.x < -1):
		mc_idle.animation = "Waddle"
	else:
		if isDead == false:
			mc_idle.animation = "Idle"
	if velocity.y < 0:
		mc_idle.animation = "Jump"
	
	if isDead == false:
		var direction: = get_direction()
		velocity = calc_move_velocity(velocity, direction, MCspeed)
		velocity = move_and_slide(velocity, floor_normal)
	
	var isLeft = velocity.x < 0
	mc_idle.flip_h = isLeft
	
func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"), -1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 1.0
	)

func calc_move_velocity(linear_velocity: Vector2, direction: Vector2, speed: Vector2) -> Vector2:
	var new_velocity: = linear_velocity
	new_velocity.x = speed.x * direction.x
	new_velocity.y += gravity * get_physics_process_delta_time()
	
	if direction.y == -1.0:
		new_velocity.y = speed.y * direction.y
	return new_velocity

func bounce():
	velocity.y = -770

func deadAnim():
	mc_idle.animation = "Dead"
	
func _on_McIdle_animation_finished() -> void:
	if(mc_idle.animation == "Dead"):
		get_tree().change_scene("res://src/Levels/GameOver.tscn")

