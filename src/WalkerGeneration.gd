extends Node2D

const Player = preload("res://src/Player.tscn")
const Exit = preload("res://src/Exit Door.tscn")
const Enemy = preload("res://src/EnemyBasic.tscn")

var borders = Rect2(1, 1, 100, 50)

onready var tileMap = $TileMap

func _ready():
	randomize()
	generate_level()

func generate_level():
	var walker = Walker.new(Vector2(50, 25), borders)
	var map = walker.walk(1200)
	walker.queue_free()
	
	var player = Player.instance()
	add_child(player)
	player.position = map.front()*64
	
	var exit = Exit.instance()
	add_child(exit)
	exit.position = walker.get_end_room().position * 64
	exit.connect("leaving_level", self, "reload_level")
	
	var enemy = Enemy.instance()
	var enemy_space = walker.step_history.duplicate()
	var enemy_position
	
	var num_of_enemies = randi() % 10 + 11
	for i in range(0, 20):
		enemy_space.shuffle()
		add_child(enemy)
		enemy.position = enemy_space.front()*64
		enemy_space.pop_front()
	
	walker.queue_free()
	for location in map:
		tileMap.set_cellv(location, -1)
	tileMap.update_bitmask_region(borders.position, borders.end)

func reload_level():
	get_tree().reload_current_scene()

func _input(event):
	if event.is_action_pressed("ui_accept"):
		reload_level()


