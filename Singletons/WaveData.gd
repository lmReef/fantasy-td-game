extends Node

var mobs_left = 0
var current_wave = 0

signal wave_over

var waves = {
	1: [
		'Scrapper',
		'Scrapper',
		'Scrapper',
	],
	2: [
		'Scrapper',
		'Scrapper',
		'Scrapper',
		'Scrapper',
		'Scrapper',
		'Scrapper',
	]
}

func mob_died():
	mobs_left -= 1
	if mobs_left == 0:
		emit_signal('wave_over')
