/obj/machinery/ai_slipper
	name = "дозатор пены"
	desc = "Дистанционно управляемый дозатор пены для борьбы с скоплением людей."
	icon = 'icons/obj/device.dmi'
	icon_state = "ai-slipper0"
	base_icon_state = "ai-slipper"
	layer = PROJECTILE_HIT_THRESHHOLD_LAYER
	plane = FLOOR_PLANE
	max_integrity = 200
	armor = list("melee" = 50, "bullet" = 20, "laser" = 20, "energy" = 20, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 30)

	var/uses = 20
	var/cooldown = 0
	var/cooldown_time = 100
	req_access = list(ACCESS_AI_UPLOAD)

/obj/machinery/ai_slipper/examine(mob/user)
	. = ..()
	. += "<span class='notice'>It has <b>[uses]</b> uses of foam remaining.</span>"

/obj/machinery/ai_slipper/update_icon_state()
	if(machine_stat & BROKEN)
		return ..()
	if((machine_stat & NOPOWER) || cooldown_time > world.time || !uses)
		icon_state = "[base_icon_state]0"
		return ..()
	icon_state = "[base_icon_state]1"
	return ..()

/obj/machinery/ai_slipper/interact(mob/user)
	if(!allowed(user))
		to_chat(user, "<span class='danger'>Access denied.</span>")
		return
	if(!uses)
		to_chat(user, "<span class='warning'>[src] в нем закончилась пена, и он не может быть активирован!</span>")
		return
	if(cooldown_time > world.time)
		to_chat(user, "<span class='warning'>[src] не может быть активирован для <b>[DisplayTimeText(world.time - cooldown_time)]</b>!</span>")
		return
	new /obj/effect/particle_effect/foam(loc)
	uses--
	to_chat(user, "<span class='notice'>Вы активируете [src]. Теперь у него есть <b>[uses]</b> использование оставшейся пены.</span>")
	cooldown = world.time + cooldown_time
	power_change()
	addtimer(CALLBACK(src, PROC_REF(power_change)), cooldown_time)
