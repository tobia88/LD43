extends Node2D

const PLAYER_PREFAB = preload("res://Objects/Player/Player.tscn")
const GHOST_PREFAB = preload("res://Objects/Ghost/Ghost.tscn")

var player : Player = null
var ghosts : Array = []

onready var cam : Camera2D = $Camera2D


func _ready()->void:
	setup_traps()
	create_player()

func setup_traps()->void:
	for i in get_children():
		if i.is_in_group("gate"):
			i.connect("on_gate_unlock", self, "on_gate_unlock")

		elif i.is_in_group("trap"):
			i.connect("on_player_enter", self, "on_player_enter_trap")


func player_dead()->void:
	purify_ghost_around_player()
	create_ghost()
	player.dead()
	refresh_player()


func refresh_player()->void:
	player.position = $StartPoint.position


func create_player()->void:
	player = PLAYER_PREFAB.instance() as Player
	$PlayerNode.add_child(player)
	refresh_player()


func purify_ghost_around_player()->void:
	for g in ghosts:
		if player.position.distance_to(g.position) < 500:
			g.on_purify()


func create_ghost()->void:
	var g = GHOST_PREFAB.instance() as Ghost
	g.position = player.position
	g.player = player
	g.connect("on_dead", self, "on_ghost_dead")

	$GhostNode.add_child(g)
	ghosts.append(g)


func on_ghost_dead(ghost:Ghost)->void:
	if ghosts.has(ghost):
		ghosts.erase(ghost)


func relink_player_to_ghosts()->void:
	for g in ghosts:
		g.player = player


func on_player_enter_trap()->void:
	player_dead()