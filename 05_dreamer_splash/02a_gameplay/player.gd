extends Node2D

var hp : int = 100

func _ready() -> void:
	$body/hpLabel.text = str(hp)

func _physics_process(_delta: float) -> void:
	var vel : Vector2 = get_global_mouse_position() - position
	vel *= 0.5
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		vel *= 0.5
		vel = vel.limit_length(5)
		$Sprite2D.show()
		$body.modulate.a = 0.5
	else:
		vel = vel.limit_length(20)
		$Sprite2D.hide()
		$body.modulate.a = 1
	position += vel
	$body.rotation = vel.x * -0.01
	for target in $Detect.get_overlapping_areas():
		var targetbody = target.get_parent()
		targetbody.hp -= 0.01
		if targetbody.hp <= 0:
			get_parent().currency += 1
	for target in $Hit.get_overlapping_areas():
		hp -= 10
		$body/hpLabel.text = str(hp)
		target.get_parent().queue_free()
		if hp <= 0:
			get_parent().gameover()
