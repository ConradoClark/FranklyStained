extends Node

class_name RunCallableOnEvent

@export var event: NodeSignal
@export var callable: Node

func _ready():
  event.connect_event(Globals.get_runnable(callable))
