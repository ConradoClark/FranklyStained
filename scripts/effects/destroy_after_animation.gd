extends Node

class_name DestroyAfterAnimation

@export var reference: Node2D
@export var animated_sprite: AnimatedSprite2D
@export var animation: String = "default"

func _ready():
  animated_sprite.play(animation)
  await animated_sprite.animation_finished
  reference.queue_free()
