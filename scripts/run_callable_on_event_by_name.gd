extends Node

class_name RunCallableOnEventByName

@export var event: Globals.Events
@export var callable: Node

func _ready():
  Globals.on_node_signal.connect(_connect_with_name(Globals.get_runnable(callable)))

func _connect_with_name(fn: Callable):
  return func(src, event_name, args):
    if not event == event_name: return
    args["source"] = src
    args["event_name"] = event_name
    fn.call(args) 
