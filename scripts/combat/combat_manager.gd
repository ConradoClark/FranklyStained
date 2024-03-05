extends Node

enum CombatState { PlayerTurn, Action, EnemyTurn, NotInCombat }
var state: CombatState

signal on_action_input(action: CombatAction)
signal on_action_cancel

func _ready():
  state = CombatState.NotInCombat
  pass

func start_combat():
  state = CombatState.PlayerTurn

func send_action_input(action: CombatAction):
  if state != CombatState.PlayerTurn: return
  on_action_input.emit(action)
  
func send_action_cancel():
  if state != CombatState.PlayerTurn: return
  on_action_cancel.emit()
