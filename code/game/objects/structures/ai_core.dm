/obj/structure/AIcore
	density = TRUE
	anchored = FALSE
	name = "\improper Ядро ИИ"
	icon = 'icons/mob/ai.dmi'
	icon_state = "0"
	desc = "The framework for an artificial intelligence core."
	max_integrity = 500
	var/state = EMPTY_CORE
	var/datum/ai_laws/laws
	var/obj/item/circuitboard/aicore/circuit
	var/obj/item/mmi/brain
	var/can_deconstruct = TRUE

/obj/structure/AIcore/Initialize()
	. = ..()
	laws = new
	laws.set_laws_config()

/obj/structure/AIcore/handle_atom_del(atom/A)
	if(A == circuit)
		circuit = null
		if((state != GLASS_CORE) && (state != AI_READY_CORE))
			state = EMPTY_CORE
			update_appearance()
	if(A == brain)
		brain = null
	. = ..()


/obj/structure/AIcore/Destroy()
	if(circuit)
		QDEL_NULL(circuit)
	if(brain)
		QDEL_NULL(brain)
	QDEL_NULL(laws)
	return ..()

/obj/structure/AIcore/latejoin_inactive
	name = "сетевое ядро искусственного интеллекта"
	desc = "Это ядро искусственного интеллекта подключено с помощью передатчиков bluespace к NTNet, что позволяет загружать в него информацию об ИИ на лету в середине рабочей смены."
	can_deconstruct = FALSE
	icon_state = "ai-empty"
	anchored = TRUE
	state = AI_READY_CORE
	var/available = TRUE
	var/safety_checks = TRUE
	var/active = TRUE

/obj/structure/AIcore/latejoin_inactive/examine(mob/user)
	. = ..()
	. += "Его передатчик, по-видимому, находится <b>[active? "on" : "off"]</b>."
	. += "<span class='notice'>Ты мог бы [active? "deactivate" : "activate"] это с помощью мультитула.</span>"

/obj/structure/AIcore/latejoin_inactive/proc/is_available()			//If people still manage to use this feature to spawn-kill AI latejoins ahelp them.
	if(!available)
		return FALSE
	if(!safety_checks)
		return TRUE
	if(!active)
		return FALSE
	var/turf/T = get_turf(src)
	var/area/A = get_area(src)
	if(!(A.area_flags & BLOBS_ALLOWED))
		return FALSE
	if(!A.power_equip)
		return FALSE
	if(!T.virtual_level_trait(ZTRAIT_STATION))
		return FALSE
	if(!istype(T, /turf/open/floor))
		return FALSE
	return TRUE

/obj/structure/AIcore/latejoin_inactive/attackby(obj/item/P, mob/user, params)
	if(P.tool_behaviour == TOOL_MULTITOOL)
		active = !active
		to_chat(user, "<span class='notice'>You [active? "activate" : "deactivate"] \the [src]'s transmitters.</span>")
		return
	return ..()

/obj/structure/AIcore/latejoin_inactive/Initialize()
	. = ..()
	GLOB.latejoin_ai_cores += src

/obj/structure/AIcore/latejoin_inactive/Destroy()
	GLOB.latejoin_ai_cores -= src
	return ..()

/obj/structure/AIcore/attackby(obj/item/P, mob/user, params)
	if(P.tool_behaviour == TOOL_WRENCH)
		return default_unfasten_wrench(user, P, 20)
	if(!anchored)
		if(P.tool_behaviour == TOOL_WELDER && can_deconstruct)
			if(state != EMPTY_CORE)
				to_chat(user, "<span class='warning'>Ядро должно быть пустым, чтобы его можно было разобрать!</span>")
				return

			if(!P.tool_start_check(user, amount=0))
				return

			to_chat(user, "<span class='notice'>Вы начинаете разбирать каркас...</span>")
			if(P.use_tool(src, user, 20, volume=50) && state == EMPTY_CORE)
				to_chat(user, "<span class='notice'>вы разобрали каркас .</span>")
				deconstruct(TRUE)
			return
	else
		switch(state)
			if(EMPTY_CORE)
				if(istype(P, /obj/item/circuitboard/aicore))
					if(!user.transferItemToLoc(P, src))
						return
					playsound(loc, 'sound/items/deconstruct.ogg', 50, TRUE)
					to_chat(user, "<span class='notice'>Вы помещаете печатную плату внутрь рамки.</span>")
					update_appearance()
					state = CIRCUIT_CORE
					circuit = P
					return
			if(CIRCUIT_CORE)
				if(P.tool_behaviour == TOOL_SCREWDRIVER)
					P.play_tool_sound(src)
					to_chat(user, "<span class='notice'>Вы прикручиваете печатную плату на место.</span>")
					state = SCREWED_CORE
					update_appearance()
					return
				if(P.tool_behaviour == TOOL_CROWBAR)
					P.play_tool_sound(src)
					to_chat(user, "<span class='notice'>Вы снимаете печатную плату.</span>")
					state = EMPTY_CORE
					update_appearance()
					circuit.forceMove(loc)
					circuit = null
					return
			if(SCREWED_CORE)
				if(P.tool_behaviour == TOOL_SCREWDRIVER && circuit)
					P.play_tool_sound(src)
					to_chat(user, "<span class='notice'>Вы отсоединяете печатную плату.</span>")
					state = CIRCUIT_CORE
					update_appearance()
					return
				if(istype(P, /obj/item/stack/cable_coil))
					var/obj/item/stack/cable_coil/C = P
					if(C.get_amount() >= 5)
						playsound(loc, 'sound/items/deconstruct.ogg', 50, TRUE)
						to_chat(user, "<span class='notice'>Вы начинаете добавлять кабели к каркасу...</span>")
						if(do_after(user, 20, target = src) && state == SCREWED_CORE && C.use(5))
							to_chat(user, "<span class='notice'>Вы добавляете кабели к каркасу.</span>")
							state = CABLED_CORE
							update_appearance()
					else
						to_chat(user, "<span class='warning'>Вам понадобится пять отрезков кабеля для подключения ядра искусственного интеллекта!</span>")
					return
			if(CABLED_CORE)
				if(P.tool_behaviour == TOOL_WIRECUTTER)
					if(brain)
						to_chat(user, "<span class='warning'>Пойми это [brain.name] сначала выберись оттуда!</span>")
					else
						P.play_tool_sound(src)
						to_chat(user, "<span class='notice'>Вы отсоединяете кабели.</span>")
						state = SCREWED_CORE
						update_appearance()
						new /obj/item/stack/cable_coil(drop_location(), 5)
					return

				if(istype(P, /obj/item/stack/sheet/rglass))
					var/obj/item/stack/sheet/rglass/G = P
					if(G.get_amount() >= 2)
						playsound(loc, 'sound/items/deconstruct.ogg', 50, TRUE)
						to_chat(user, "<span class='notice'>Вы начинаете вставлять стеклянную панель...</span>")
						if(do_after(user, 20, target = src) && state == CABLED_CORE && G.use(2))
							to_chat(user, "<span class='notice'>Вы вставляете стеклянную панель.</span>")
							state = GLASS_CORE
							update_appearance()
					else
						to_chat(user, "<span class='warning'>Вам понадобятся два листа армированного стекла, чтобы вставить их в ядро искусственного интеллекта!</span>")
					return

				if(istype(P, /obj/item/aiModule))
					if(brain && brain.laws.id != DEFAULT_AI_LAWID)
						to_chat(user, "<span class='warning'>Установленный [brain.name] уже установлены законы!</span>")
						return
					var/obj/item/aiModule/module = P
					module.install(laws, user)
					return

				if(istype(P, /obj/item/mmi) && !brain)
					var/obj/item/mmi/M = P
					if(!M.brain_check(user))
						return

					var/mob/living/brain/B = M.brainmob
					if(!CONFIG_GET(flag/allow_ai) || (is_banned_from(B.ckey, "AI") && !QDELETED(src) && !QDELETED(user) && !QDELETED(M) && !QDELETED(user) && Adjacent(user)))
						if(!QDELETED(M))
							to_chat(user, "<span class='warning'>Этот [M.name] кажется, не подходит!</span>")
						return
					if(!user.transferItemToLoc(M,src))
						return

					brain = M
					to_chat(user, "<span class='notice'>Ты добавляешь [M.name] к каркасу.</span>")
					update_appearance()
					return

				if(P.tool_behaviour == TOOL_CROWBAR && brain)
					P.play_tool_sound(src)
					to_chat(user, "<span class='notice'>Ты достаешь мозг.</span>")
					brain.forceMove(loc)
					brain = null
					update_appearance()
					return

			if(GLASS_CORE)
				if(P.tool_behaviour == TOOL_CROWBAR)
					P.play_tool_sound(src)
					to_chat(user, "<span class='notice'>Ты убираешь стеклянные листы.</span>")
					state = CABLED_CORE
					update_appearance()
					new /obj/item/stack/sheet/rglass(loc, 2)
					return

				if(P.tool_behaviour == TOOL_SCREWDRIVER)
					P.play_tool_sound(src)
					to_chat(user, "<span class='notice'>Ты подключаешь монитор.</span>")
					if(brain)
						var/mob/living/brain/B = brain.brainmob
						SSticker.mode.remove_antag_for_borging(B.mind)

						var/mob/living/silicon/ai/A = null

						if (brain.overrides_aicore_laws)
							A = new /mob/living/silicon/ai(loc, brain.laws, B)
						else
							A = new /mob/living/silicon/ai(loc, laws, B)

						if(brain.force_replace_ai_name)
							A.fully_replace_character_name(A.name, brain.replacement_ai_name())
						SSblackbox.record_feedback("amount", "ais_created", 1)
						deadchat_broadcast(" был размещен в Сети по адресу <b>[get_area_name(A, TRUE)]</b>.", "<span class='name'>[A]</span>", follow_target=A, message_type=DEADCHAT_ANNOUNCEMENT)
						qdel(src)
					else
						state = AI_READY_CORE
						update_appearance()
					return

			if(AI_READY_CORE)
				if(istype(P, /obj/item/aicard))
					P.transfer_ai("INACTIVE", "AICARD", src, user)
					return

				if(P.tool_behaviour == TOOL_SCREWDRIVER)
					P.play_tool_sound(src)
					to_chat(user, "<span class='notice'>Ты отключаешь монитор от каркаса.</span>")
					state = GLASS_CORE
					update_appearance()
					return
	return ..()

/obj/structure/AIcore/update_icon_state()
	switch(state)
		if(EMPTY_CORE)
			icon_state = "0"
		if(CIRCUIT_CORE)
			icon_state = "1"
		if(SCREWED_CORE)
			icon_state = "2"
		if(CABLED_CORE)
			if(brain)
				icon_state = "3b"
			else
				icon_state = "3"
		if(GLASS_CORE)
			icon_state = "4"
		if(AI_READY_CORE)
			icon_state = "ai-empty"
	return ..()

/obj/structure/AIcore/deconstruct(disassembled = TRUE)
	if(state == GLASS_CORE)
		new /obj/item/stack/sheet/rglass(loc, 2)
	if(state >= CABLED_CORE)
		new /obj/item/stack/cable_coil(loc, 5)
	if(circuit)
		circuit.forceMove(loc)
		circuit = null
	new /obj/item/stack/sheet/plasteel(loc, 4)
	qdel(src)

/obj/structure/AIcore/deactivated
	name = "inactive AI"
	icon_state = "ai-empty"
	anchored = TRUE
	state = AI_READY_CORE

/obj/structure/AIcore/deactivated/Initialize()
	. = ..()
	circuit = new(src)


/*
This is a good place for AI-related object verbs so I'm sticking it here.
If adding stuff to this, don't forget that an AI need to cancel_camera() whenever it physically moves to a different location.
That prevents a few funky behaviors.
*/
//The type of interaction, the player performing the operation, the AI itself, and the card object, if any.


/atom/proc/transfer_ai(interaction, mob/user, mob/living/silicon/ai/AI, obj/item/aicard/card)
	if(istype(card))
		if(card.flush)
			to_chat(user, "<span class='alert'>ERROR: Выполняется очистка искусственного интеллекта, не удается выполнить протокол передачи.</span>")
			return FALSE
	return TRUE

/obj/structure/AIcore/transfer_ai(interaction, mob/user, mob/living/silicon/ai/AI, obj/item/aicard/card)
	if(state != AI_READY_CORE || !..())
		return
//Transferring a carded AI to a core.
	if(interaction == AI_TRANS_FROM_CARD)
		AI.control_disabled = FALSE
		AI.radio_enabled = TRUE
		AI.forceMove(loc) // to replace the terminal.
		to_chat(AI, "<span class='notice'>Вы были загружены на стационарный терминал. Подключение к удаленному устройству восстановлено.</span>")
		to_chat(user, "<span class='boldnotice'>Передача прошла успешно</span>: [AI.name] ([rand(1000,9999)].exe) установлен и успешно запущен. Локальная копия была удалена.")
		card.AI = null
		AI.battery = circuit.battery
		qdel(src)
	else //If for some reason you use an empty card on an empty AI terminal.
		to_chat(user, "<span class='alert'>На этом терминале нет загруженного искусственного интеллекта.</span>")

/obj/item/circuitboard/aicore
	name = "AI core (AI Core Board)" //Well, duh, but best to be consistent
	var/battery = 200 //backup battery for when the AI loses power. Copied to/from AI mobs when carding, and placed here to avoid recharge via deconning the core
