extends Node

class_name CombatAction

enum Position { UP, RIGHT, DOWN, LEFT}

@export var position: Position
@export var label: Label
var action: ActionDefinition

func _ready():
  pass
  
func set_action(act: ActionDefinition):
  action = act
  label.text = action.action_name

func _input(event):
  var condition = (event.is_action_pressed("action_up") and position == Position.UP) \
    or (event.is_action_pressed("action_down") and position == Position.DOWN) \
    or (event.is_action_pressed("action_left") and position == Position.LEFT) \
    or (event.is_action_pressed("action_right") and position == Position.RIGHT)
  if condition:
    CombatManager.send_action_input(self)
