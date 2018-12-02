extends Node2D

const PLAYER_PREFAB = preload("res://Objects/Player/Player.tscn")
const GHOST_PREFAB = preload("res://Objects/Ghost/Ghost.tscn")

var player : Player = null
var ghosts : Array = []


func _ready():
	setup_traps()
	create_player()


func setup_traps():
	for i in get_children():
		if i.name == "GroundTrap":
			var trap = i as GroundTrap
			trap.connect("on_player_enter", self, "on_player_enter_trap")


func player_dead():
	purify_ghost_around_player()
	create_ghost()
	player.dead()
	create_player()
	relink_player_to_ghosts()


func create_player():
	player = PLAYER_PREFAB.instance() as Player
	$PlayerNode.add_child(player)
	player.position = $StartPoint.position


func purify_ghost_around_player():
	for g in ghosts:
		if player.position.distance_to(g.position) < 500:
			ghosts.erase(g)
			g.dead()


func create_ghost():
	var g = GHOST_PREFAB.instance() as Ghost
	g.position = player.position
	$GhostNode.add_child(g)
	ghosts.append(g)


func relink_player_to_ghosts():
	for g in ghosts:
		if g != null:
			g.player = player


func on_player_enter_trap():
	player_dead()