extends CharacterBody2D

@onready var health_bar = $"../Healthbar"
@onready var _animation_player = $AnimationPlayer

var health = 60
var state = "idle"
var can_hit = true

func set_state(s,cooldown):
	state = s
	_animation_player.play(s)
	can_hit = false
	$hit_cooldown.wait_time = cooldown
	$hit_cooldown.start()

func _ready() -> void:
	health_bar.value = health
	
func _process(_delta: float) -> void:
	
	if Input.is_action_just_pressed("Action_1") and can_hit:
		print("A")
		if state == "idle":
			set_state("A", 0.1)
		elif state == "A":
			set_state("AA", 0.2)
		elif state == "AA":
			set_state("AAA", 0.5)
	if Input.is_action_just_pressed("Action_2"):
		print("B")
	if _animation_player.is_playing() == false:
		set_state("idle", 0.1)
		
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


func _on_timer_timeout() -> void:
	can_hit = true
