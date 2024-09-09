extends CharacterBody2D

@onready var health_bar = $"../Healthbar"
@onready var _animation_player = $AnimationPlayer

var health = 100
var state = "idle"
var can_hit = true

func set_state(s,cooldown,sound):
	state = s
	_animation_player.play(s)
	sound.play()
	can_hit = false
	$hit_cooldown.wait_time = cooldown
	$hit_cooldown.start()

func _ready() -> void:
	health_bar.value = health
	
func _process(_delta: float) -> void:
	
	if Input.is_action_just_pressed("Action_1") and can_hit:
		if state == "idle":
			set_state("A", 0.1, $"Sounds/A-Jab")
		elif state == "A":
			#Give "Crouch" Animation I-Frames
			set_state("AA", 0.25, $"Sounds/AA-Uppercut")
		elif state == "AA":
			set_state("AAA", 0.3, $"Sounds/AAA-LiverPunch")
		elif state == "B":
			set_state("BA", 0.2, $"Sounds/BA-ElbowHit")
		elif state == "BB":
			set_state("BBA", 0.3, $"Sounds/BBA-OverheadPunch")
	if Input.is_action_just_pressed("Action_2") and can_hit:
		if state == "idle":
			set_state("B", 0.15, $"Sounds/B-AnkleKick")
		elif state == "B":
			set_state("BB", 0.3, $"Sounds/BB-SideKick")
		elif state == "BB":
			set_state("BBB", 0.3, $"Sounds/BBB-Stomp")
		elif state == "A":
			set_state("AB", 0.2, $"Sounds/AB-Stand")
		elif state == "AB":
			set_state("ABB", 0.3, $"Sounds/ABB-HighKick")
		elif state == "BA":
			set_state("BAB", 0.3, $"Sounds/BAB-HandKick")
	if _animation_player.is_playing() == false:
		set_state("idle", 0.01, $"Sounds/IdleNone")
		
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
