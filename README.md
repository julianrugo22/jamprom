ruido de movimiento
ruido de no movimiento
ruido de dash (escopetoso)
ruido de melee (golpe de arena)
ruido de enemigo muriendo/ impacto
ruido de fuego recargando
ruido de poco/nada de fueguito
ruido ambiente (gas saliendo)




var BREAKPOINT_SPEEDS = [0]
var INSTANT_ACCELERATION = [420]
var INSTANT_DECCELERATION = [500]



var _instant_acceleration = 0
var _instant_decceleration = 0
	
	for i in range(len(Param.BREAKPOINT_SPEEDS)):
		if Param.BREAKPOINT_SPEEDS[i] > _momentum:
			continue
		_instant_acceleration = Param.INSTANT_ACCELERATION[i]
		_instant_decceleration = Param.INSTANT_DECCELERATION[i]
		break
