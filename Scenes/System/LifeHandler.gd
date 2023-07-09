extends Control

func _ready():
	SignalBus.lose_life.connect(_on_lose_life)
	
	match Global.lives:
		3:
			pass
		2:
			$HBoxContainer/Life2.visible = false
		1:
			$HBoxContainer/Life2.visible = false
			$HBoxContainer/Life1.visible = false
	
func _on_lose_life():
	get_node('HBoxContainer/Life' + str(Global.lives)).visible = false
