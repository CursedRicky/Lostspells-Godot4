extends Node

var canRain = true
var canPause = true
var weather = "none"
var player_node: Player = null
var shake = false
var death = false
var speedMult = 1
var player
var casting = false

var key = 10


var cameraFollow = true
var canAttack = true
var canMove = true
var canRoll = true

var shakeStr = 1

var healtPotion = 0

var isInvisible = false

var isInventoryOpen = true

var playerEsce = false
var coord

func set_player_reference(player):
	player_node = player

var max_rooms = 10
var min_rooms = 8
var roomToMade = 0

var itemsLoad = [
	"res://Inventory/Items/healingPotion.tres",
	"res://Inventory/Items/manaPotion.tres"
]
