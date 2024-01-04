extends Node2D

onready var score_txt: Label = $scoreHUD/scoreTxt

func _process(_delta):
	if $Player.position.x < 2100:
		$Camera2D.position.x = $Player.position.x
	score_txt.text = String(GlobalScore.score)
	

func add_score(points: int):
	GlobalScore.score += points
	score_txt.text = String(GlobalScore.score)

func _on_Area2D_body_entered(body: Node) -> void:
	get_tree().change_scene("res://src/Levels/GameOver.tscn")
	
func _on_completezone_body_entered(body: Node) -> void:
	get_tree().change_scene("res://src/Levels/Complete.tscn")
