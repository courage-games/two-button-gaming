extends CharacterBody2D

@onready var health_bar = $"../HealthbarPlayer2"
@onready var _animation_player = $AnimationPlayer2

var health = 100
var state = "idle"
var can_hit = true
var damage = 0

func set_state(s,cooldown,sound, dmg):
	damage = dmg
	state = s
	_animation_player.play(s)
	sound.play()
	can_hit = false
	$hit_cooldown.wait_time = cooldown
	$hit_cooldown.start()

func _ready() -> void:
	health_bar.value = health
	
func _process(_delta: float) -> void:
	
	if Input.is_action_just_pressed("Action_1_Player2") and can_hit:
		if state == "idle":
			set_state("A", 0.1, $"Sounds/A-Jab", 2)
		elif state == "A":
			#Give "Crouch" Animation I-Frames
			set_state("AA", 0.25, $"Sounds/AA-Uppercut", 4)
		elif state == "AA":
			set_state("AAA", 0.3, $"Sounds/AAA-LiverPunch", 5)
		elif state == "AB":
			set_state("ABA", 0.3, $"Sounds/ABA-Headbutt", 5)
		elif state == "B":
			set_state("BA", 0.2, $"Sounds/BA-ElbowHitRight", 3)
		elif state == "BA":
			set_state("BAA", 0.2, $"Sounds/BAA-ElbowHitLeft", 3)
		elif state == "BB":
			set_state("BBA", 0.3, $"Sounds/BBA-OverheadPunch", 7)
	if Input.is_action_just_pressed("Action_2_Player2") and can_hit:
		if state == "idle":
			set_state("B", 0.15, $"Sounds/B-AnkleKick", 2)
		elif state == "B":
			set_state("BB", 0.3, $"Sounds/BB-SideKick", 3)
		elif state == "BB":
			set_state("BBB", 0.3, $"Sounds/BBB-Stomp", 6)
		elif state == "A":
			set_state("AB", 0.2, $"Sounds/AB-Stand", 0)
		elif state == "AA":
			set_state("AAB", 0.3, $"Sounds/AAB-BackKick", 5)
		elif state == "AB":
			set_state("ABB", 0.3, $"Sounds/ABB-HighKick", 4)
		elif state == "BA":
			set_state("BAB", 0.3, $"Sounds/BAB-HandKick", 5)
			
	if _animation_player.is_playing() == false:
		set_state("idle", 0.01, $"Sounds/IdleNone", 0)

func _on_add_health():
	if health < 100:
		health += 10
		health_bar.value = health
	
func _on_subtract_health(amount):
	if health > 0:
		health -= amount
		health_bar.value = health
	if health <= 0:
		$"../DeathSound".play()
		queue_free()

func _on_timer_timeout() -> void:
	can_hit = true

func _on_hitbox_arm_body_entered(body: Node2D) -> void:
	if body != self:
		body._on_subtract_health(damage)
		body.set_state("Hurt", 0.3, $"Sounds/IdleNone", 0)

func _on_hitbox_leg_body_entered(body: Node2D) -> void:
	if body != self:
		body._on_subtract_health(damage)
		body.set_state("Hurt", 0.3, $"Sounds/IdleNone", 0)
