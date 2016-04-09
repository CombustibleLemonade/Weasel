extends Node

var gen_size = 30

var target = "me_thinks_it_is_like_a_weasel"
var chars = [
'a', 'b', 'c', 
'd', 'e', 'f', 
'g', 'h', 'i', 
'j', 'k', 'l', 
'm', 'n', 'o', 
'p', 'q', 'r', 
's', 't', 'u', 
'v', 'w', 'x', 
'y', 'z', '_']

var creatures = []
var gen_count = 0

func _ready():
	# Make sure we're not getting the same random numbers each time
	randomize()
	
	for i in range (gen_size):
		var creature = ""
		for i in range( target.length() ):
			creature += chars[randi() % chars.size()]
		
		creatures.push_back(creature)
	
	while not target_reached():
		compute_generation()
		gen_count += 1
	
	print(gen_count)

func compute_generation():
	var best_value = target.length()
	var best
	
	# Get the best creature
	for i in creatures:
		if diff(i) < best_value:
			best = i
			best_value = diff(i)
	
	creatures = []
	
	# Mutate the best creature
	creatures.push_back(best)
	
	for i in range(1, gen_size):
		creatures.push_back(mutate(best))


# Adds a mutation
func mutate (var c):
	# Index we're going to mutate at
	var m_i = randi() % c.length()
	
	c[m_i] = chars[randi() % chars.size()]
	return c

func diff(var c):
	var diff_count = 0
	
	for i in range(min(c.length(), target.length())):
		if c[i] != target[i]:
			diff_count += 1
	
	return diff_count

func target_reached():
	for i in creatures:
		if i == target:
			return true
	
	return false