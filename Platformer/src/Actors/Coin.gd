extends Area2D

onready var coin: AnimatedSprite = $coin
var level

func _process(_delta):
	var levelName = get_tree().get_current_scene().get_name()
	if levelName == "Level1":
		level = get_node("/root/Level1")
	if levelName == "Level2":
		level = get_node("/root/Level2")
	if levelName == "Level3":
		level = get_node("/root/Level3")

func _on_Coin_body_entered(body):
	if body.get_collision_layer_bit(0):
		if level.has_method("add_score"):
			level.add_score(1)
		$coin.animation = "collect"
		
func _on_coin_animation_finished() -> void:
	if($coin.animation == "collect"):
		queue_free()
