extends Node

@export var maxHealt = 100
@export var maxMana = 100
@onready var mana = maxMana
@onready var healt = maxHealt


@export var crit = 30
@export var critDmg = .5
@export var manaRegen = 2

var critMult = .5

var str = 0
var armor = 1
var res = 1 + armor*.05
var souls = 0
var lvl = 0
var exp = 0
var maxExp = 10
var skillPoint = 10
var ms = 100

var gold = 0

var armorLvl = 0
var critLvl = 0
var msLvl = 0
var healtLvl = 0
var manaRegenLvl = 0
var adLvl = 0

var ad = 25

var canRegenerateStamina = true
var maxStamina = 100
@onready var stamina = maxStamina

	
