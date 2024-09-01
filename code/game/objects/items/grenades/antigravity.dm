/obj/item/grenade/antigravity
	name = "антигравитационная граната"
	icon_state = "emp"
	item_state = "emp"

	var/range = 7
	var/forced_value = 0
	var/duration = 300

/obj/item/grenade/antigravity/prime()
	. = ..()
	update_mob()

	for(var/turf/T in view(range,src))
		T.AddElement(/datum/element/forced_gravity, forced_value)
		addtimer(CALLBACK(T, TYPE_PROC_REF(/datum, _RemoveElement), list(forced_value)), duration)

	resolve()
