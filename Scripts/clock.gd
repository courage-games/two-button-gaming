extends Label

var number = 99

func _on_timer_timeout() -> void:
	number -= 1
	$".".text = str(number)
	if number == 0:
		$".".text = 'Time Out'
		$Timer.queue_free()
func _process(delta: float) -> void:
	if $"../Player" == null:
		$Timer.stop()
		$".".text = "Player 2 Wins!"
	elif $"../Player2" == null:
		$Timer.stop()
		$".".text = "Player 1 Wins!"
