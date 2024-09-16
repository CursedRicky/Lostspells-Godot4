extends Node2D

var rarities = {"Common" : 1000,
				"Uncommon" : 700,
				"Rare" : 500,
				"Epic" : 250,
				"Leggendary" : 100}
				
var rng = RandomNumberGenerator.new()

func get_rarity():
	rng.randomize()
	
	var weighted_sum = 0
	
	for n in rarities:
		weighted_sum += rarities[n]
		
	var item = rng.randi_range(0, weighted_sum)
	
	for n in rarities:
		if item <= rarities[n]:
			return n
		item -= rarities[n] 
