extends Node

enum Events {  }

signal on_node_signal(source: Node, event_name: Events, args: Dictionary)

func change_scene_loaded(scene: PackedScene):
  var instance = scene.instantiate()
  get_tree().root.add_child(instance)
  await get_tree().process_frame
  var old_scene = get_tree().current_scene
  get_tree().current_scene = instance
  old_scene.free()

func change_scene(scene: String):
  var instance = load(scene).instantiate()
  get_tree().root.add_child(instance)
  await get_tree().process_frame
  var old_scene = get_tree().current_scene
  get_tree().current_scene = instance
  old_scene.free()
  
func connect_node_signal_by_event(event_name: Events, fn_owner: Node, fn: Callable):
  if fn == null:
    return
  var instance_id = fn_owner.get_instance_id()
  connected_signals[instance_id] = func(source, event, arguments): 
    if event != event_name: return
    if not fn.get_object():
      if connected_signals.has(instance_id):
        on_node_signal.disconnect(connected_signals[instance_id])
        connected_signals.erase(instance_id)
      return
    fn.call(arguments)
  on_node_signal.connect(connected_signals[instance_id])
  
var connected_signals = {}
var runnables = {}

func emit_node_signal(source: Node, event_name: Events, args: Dictionary):
  on_node_signal.emit(source,event_name,args)

func add_as_runnable(obj: Node, fn: Callable):
  runnables[obj.get_instance_id()] = fn
  obj.child_exiting_tree.connect(remove_from_runnables)
  
func get_runnable(obj:Node) -> Callable:
  var instance_id = obj.get_instance_id()
  if not runnables.has(instance_id): return func(args:Dictionary): pass
  return runnables[instance_id] as Callable

func remove_from_runnables(obj: Node):
  runnables.erase(obj.get_instance_id())
