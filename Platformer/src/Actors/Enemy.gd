extends KinematicBody2D

onready var santa: AnimatedSprite = $Santa
onready var enemy: KinematicBody2D = $"."

var is_moving_left = true
var is_attacking = false
var isDead = false

var gravity = 10
var velocity = Vector2(0, 0)

var level
var speed = 64

func _ready():
	$Santa.animation = "walk"
	
func _process(_delta):
	if isDead == false:
		move_character()
		detect_turn_around()
	
	var levelName = get_tree().get_current_scene().get_name()
	if levelName == "Level1":
		level = get_node("/root/Level1")
	if levelName == "Level2":
		level = get_node("/root/Level2")
	if levelName == "Level3":
		level = get_node("/root/Level3")
	
func move_character():
	velocity.x = -speed if is_moving_left else speed
	velocity.y += gravity
	
	velocity = move_and_slide(velocity, Vector2.UP)

func detect_turn_around():
	if not $RayCast2D.is_colliding() and is_on_floor():
		is_moving_left =! is_moving_left
		scale.x = -scale.x
		
func hit():
	$AttackDetector.monitoring = true

func end_of_hit():
	$AttackDetector.monitoring = false
	
func start_walk():
	$Santa.animation = "walk"

func _on_PlayerDetector_body_entered(body) -> void:
	is_attacking = true
	$Santa.animation = "punch"
	body.life -= 1
	body.deadAnim()
	body.isDead = true
	is_attacking = false
	$Santa.animation = "idle"

func _on_PlayerDetector_body_exited(_body: Node) -> void:
	is_attacking = false
	$Santa.animation = "walk"

func _on_top_checker_body_entered(body):
	$Santa.animation = "hit"
	isDead = true
	if level.has_method("add_score"):
		level.add_score(5)
	body.bounce()

func _on_Santa_animation_finished() -> void:
	if($Santa.animation == "hit"):
		enemy.queue_free()
