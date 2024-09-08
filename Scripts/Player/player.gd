extends CharacterBody2D


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Action_1"):
		print("A")
	if Input.is_action_just_pressed("Action_2"):
		print("B")
