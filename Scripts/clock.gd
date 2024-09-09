extends Label

var number = 99

func _on_timer_timeout() -> void:
	number -= 1
	$".".text = str(number)
	if number == 0:
		$".".text = 'Time Out'
		$Timer.queue_free()
