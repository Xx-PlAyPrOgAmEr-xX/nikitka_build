/obj/item/wrench
	name = "гаечный ключ"
	desc = "Гаечный ключ для обычного использования. Его можно взять в руки. Это трубный ключ."
	icon = 'icons/obj/tools.dmi'
	icon_state = "wrench_pipe" //now where could my pipe wrench be?
	lefthand_file = 'icons/mob/inhands/equipment/tools_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/tools_righthand.dmi'
	flags_1 = CONDUCT_1
	slot_flags = ITEM_SLOT_BELT
	force = 5
	throwforce = 7
	w_class = WEIGHT_CLASS_SMALL
	usesound = 'sound/items/ratchet.ogg'
	custom_materials = list(/datum/material/iron=150)
	drop_sound = 'sound/items/handling/wrench_drop.ogg'
	pickup_sound =  'sound/items/handling/wrench_pickup.ogg'

	attack_verb = list("bashed", "battered", "bludgeoned", "whacked")
	tool_behaviour = TOOL_WRENCH
	toolspeed = 1
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 30)

/obj/item/wrench/abductor
	name = "инопланетый гаечный ключ"
	desc = "Гаечный ключ с поляризацией. Он поворачивает все, что находится между зажимами."
	icon = 'icons/obj/abductor.dmi'
	icon_state = "wrench"
	usesound = 'sound/effects/empulse.ogg'
	toolspeed = 0.1


/obj/item/wrench/medical
	name = "медицинский гаечный ключ"
	desc = "Медицинский гаечный ключ для обычного (медицинского?) использования. Его можно найти в вашей руке."
	icon_state = "wrench_medical"
	item_state = "wrench"
	force = 2 //MEDICAL
	throwforce = 4
	attack_verb = list("healed", "medicaled", "tapped", "poked", "analyzed", "cobbyed") //"cobbyed" //i dont know who added this comment but now it's a thing - zeta

/obj/item/wrench/medical/examine(mob/user)
	. = ..()

/obj/item/wrench/cyborg
	name = "гидравлический ключ"
	desc = "Усовершенствованный роботизированный гаечный ключ, приводимый в действие внутренней гидравликой. В два раза быстрее, чем портативная версия."
	icon = 'icons/obj/items_cyborg.dmi'
	icon_state = "wrench_cyborg"
	toolspeed = 0.5

/obj/item/wrench/combat
	name = "боевой гаечный ключ"
	desc = "Он похож на обычный гаечный ключ, но более острый. Его можно найти на поле боя."
	icon_state = "wrench_combat"
	item_state = "wrench_combat"
	tool_behaviour = null
	toolspeed = null
	var/on = FALSE

/obj/item/wrench/combat/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

/obj/item/wrench/combat/attack_self(mob/living/user)
	if(on)
		on = FALSE
		force = initial(force)
		w_class = initial(w_class)
		throwforce = initial(throwforce)
		tool_behaviour = initial(tool_behaviour)
		attack_verb = list("bopped")
		toolspeed = initial(toolspeed)
		playsound(user, 'sound/weapons/saberoff.ogg', 5, TRUE)
		to_chat(user, "<span class='warning'>[src] can now be kept at bay.</span>")
	else
		on = TRUE
		force = 15
		w_class = WEIGHT_CLASS_NORMAL
		throwforce = 10
		tool_behaviour = TOOL_WRENCH
		attack_verb = list("devastated", "brutalized", "committed a war crime against", "obliterated", "humiliated")
		toolspeed = 0.5
		hitsound = 'sound/weapons/blade1.ogg'
		playsound(user, 'sound/weapons/saberon.ogg', 5, TRUE)
		to_chat(user, "<span class='warning'>[src] is now active. Woe onto your enemies!</span>")
	update_appearance()

/obj/item/wrench/combat/update_icon_state()
	if(on)
		icon_state = "[initial(icon_state)]_on"
		item_state = "[initial(item_state)]1"
	else
		icon_state = "[initial(icon_state)]"
		item_state = "[initial(item_state)]"
	return ..()

/obj/item/wrench/syndie
	name = "подозрительный на вид гаечный ключ"
	desc = "It's one of those fancy wrenches that you turn backward without twisting the bolt for faster action."
	icon_state = "wrench_syndie"
	toolspeed = 0.5

/obj/item/wrench/crescent
	name = "crescent wrench"
	desc = "A wrench with common uses. Can be found in your hand. This one is a crescent wrench."
	icon_state = "wrench"

/obj/item/wrench/old
	desc = "A wrench with common uses. Can be found in your hand. This one seems ancient!"
	icon = 'icons/obj/tools.dmi'
	icon_state = "oldwrench"
