extends Node

class_name CombatGauge

@export var rect: NinePatchRect
@export var ui_right_symbol: Sprite2D
var size_multiplier = 16.

func _ready():
  rect.size.x = PlayerStats.max_stamina * size_multiplier
  ui_right_symbol.position.x = rect.size.x
