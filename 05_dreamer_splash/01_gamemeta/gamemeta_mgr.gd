extends Node

var SHOP = load("res://05_dreamer_splash/02b_shopscreen/dream_shopscreen.tres")
var GAMEPLAY = load("res://05_dreamer_splash/02a_gameplay/dream_gameplay.tres")

func _ready() -> void:
	if Dreamer.first('gmmgr initialized'):
		Dreamer.w('levelindex',0)
		Dreamer.w('currency',10)
		Dreamer.w('map',[0,"s",1,5,2,3,6,3,4,10,"x"])
	else:
		Dreamer.w('levelindex',Dreamer.r('levelindex')+1)
	
	var mapvalue = Dreamer.r('map')[Dreamer.r('levelindex')]
	
	if mapvalue is int:
		Dreamer.w('gameplay difficulty', int(mapvalue))
		Dreamer.dream(GAMEPLAY)
	else:
		match mapvalue:
			's':
				Dreamer.dream(SHOP)
			_:
				Dreamer.wake()
