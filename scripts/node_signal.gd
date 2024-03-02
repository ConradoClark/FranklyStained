extends Node

class_name NodeSignal

@export var source: Node
@export var event_name: Globals.Events

func emit(args: Dictionary):
  Globals.on_node_signal.emit(source, event_name, args)
  
func connect_event(fn: Callable):
  Globals.on_node_signal.connect(_connect_with_source(fn))

func _connect_with_source(fn: Callable):
  return func(src, ev_name, args):
    if not source == src or event_name != ev_name: return
    args["source"] = src
    args["event_name"] = ev_name
    fn.call(args) 
