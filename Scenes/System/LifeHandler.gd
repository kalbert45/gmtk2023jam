extends Control

func _ready():
	SignalBus.lose_life.connect(_on_lose_life)
	
	match Global.lives:
		3:
			$HBoxContainer/Life0.visible = true
			$HBoxContainer/Life1.visible = true
			$HBoxContainer/Life2.visible = true
		2:
			$HBoxContainer/Life0.visible = true
			$HBoxContainer/Life1.visible = true
			$HBoxContainer/Life2.visible = false
		1:
			$HBoxContainer/Life0.visible = true
			$HBoxContainer/Life2.visible = false
			$HBoxContainer/Life1.visible = false
	
func _on_lose_life():
	get_node('HBoxContainer/Life' + str(Global.lives)).visible = false
