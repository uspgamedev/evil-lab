extends StaticBody2D

onready var arrow = get_node("Arrow")

func interact(character):
	print('s')
	if (!arrow.is_hidden()):
		arrow.hide()
	else:
		arrow.show()
	