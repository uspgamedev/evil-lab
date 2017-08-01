extends SamplePlayer2D

export(Sample) var sample

func _ready():
	get_sample_library().add_sample("default", sample)

func go():
	return play("default")
