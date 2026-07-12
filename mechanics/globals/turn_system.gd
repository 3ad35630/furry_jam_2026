extends Node

signal round_ended()
signal round_started()

var current_round : int = 0

func end_round():
	round_ended.emit()
	current_round+=1
	round_started.emit()
