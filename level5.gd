extends Node2D

@onready var wall = $Wall

func _physics_process(delta):
	wall.constant_angular_velocity=0.08
	wall.rotate(0.001)
	
