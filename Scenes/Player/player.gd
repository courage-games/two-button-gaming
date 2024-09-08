extends CharacterBody2D

@onready var health_bar = $"../Healthbar"

var health = 60

func _ready() -> void:
	health_bar.value = health
	
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_up"):
		_on_add_health()
	if Input.is_action_just_pressed("ui_down"):
		_on_subtract_health()

func _on_add_health():
	if health < 100:
		health += 10
		health_bar.value = health
	
func _on_subtract_health():
	if health > 0:
		health -= 10
		health_bar.value = health
	if health <= 0:
		queue_free()
