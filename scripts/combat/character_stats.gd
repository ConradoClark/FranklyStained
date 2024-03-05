extends Resource

class_name CharacterStats

@export var head: CharacterPart
@export var torso: CharacterPart

@export var high: CharacterPart
@export var low: CharacterPart
@export var right: CharacterPart
@export var left: CharacterPart

var current_stats: Stats
var current_hp: int

func _ready():
  _calculate_stats()
  current_hp = current_stats.max_hp

func _calculate_stats():
  current_stats = Stats.new()
  current_stats.max_hp = head.stats.max_hp + torso.stats.max_hp + high.stats.max_hp + \
    low.stats.max_hp + right.stats.max_hp + left.stats.max_hp
  current_stats.attack = head.stats.attack + torso.stats.attack
  current_stats.defense = head.stats.defense + torso.stats.defense
  
