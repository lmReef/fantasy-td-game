extends Node

var mobs_left = 0
var current_wave = 0

var difficulty = 2
var BASE_BUDGET = 30
var budget = 30

signal wave_over

func get_mob(cost):
	var mobs = MobData.filter_wave_available(current_wave)
	mobs.shuffle()
	
	for i in mobs:
		if MobData.mobs[i].cost <= cost:
			return i

func generate_wave():
	var mobs = []
	var wave_budget = budget
	
	while wave_budget > 0:
		var mob = get_mob(wave_budget)
		if mob:
			wave_budget -= MobData.mobs[mob].cost
			mobs.append(mob)
		else:
			wave_budget = 0

	mobs_left = mobs.size()
	return mobs

func mob_died():
	mobs_left -= 1
	if mobs_left == 0:
		wave_over()

func wave_over():
	emit_signal('wave_over')
	calculate_difficulty()
	calculate_budget()

func calculate_difficulty():
	difficulty = (2 + current_wave) * (pow(1.08, float(current_wave)))

func calculate_budget():
	budget = BASE_BUDGET * (difficulty * 0.65)
	#print('Budget: ' + String(budget))
