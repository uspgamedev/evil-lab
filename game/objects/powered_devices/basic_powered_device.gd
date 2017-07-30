extends StaticBody2D

var power_cell

func _ready():
	power_cell = get_tree().get_root().get_node("Main").find_power_cell(self)
