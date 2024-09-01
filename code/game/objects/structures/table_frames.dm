/* Table Frames
 * Contains:
 *		Frames
 *		Wooden Frames
 */


/*
 * Normal Frames
 */

/obj/structure/table_frame
	name = "рама стола"
	desc = "Четыре металлические ножки с четырьмя каркасными стержнями для стола. Вы можете легко пройти через это."
	icon = 'icons/obj/structures.dmi'
	icon_state = "table_frame"
	density = FALSE
	anchored = FALSE
	layer = PROJECTILE_HIT_THRESHHOLD_LAYER
	max_integrity = 100
	var/framestack = /obj/item/stack/rods
	var/framestackamount = 2

/obj/structure/table_frame/attackby(obj/item/I, mob/user, params)
	if(I.tool_behaviour == TOOL_WRENCH)
		to_chat(user, "<span class='notice'>Вы начинаете разбирать [src]...</span>")
		I.play_tool_sound(src)
		if(I.use_tool(src, user, 30))
			playsound(src.loc, 'sound/items/deconstruct.ogg', 50, TRUE)
			deconstruct(TRUE)
		return

	var/obj/item/stack/material = I
	if (istype(material))
		if(material?.tableVariant)
			if(material.get_amount() < 1)
				to_chat(user, "<span class='warning'>тебе нужно [material.name] лист, чтобы сделать это!</span>")
				return
			to_chat(user, "<span class='notice'>You start adding [material] to [src]...</span>")
			if(do_after(user, 20, target = src) && material.use(1))
				make_new_table(material.tableVariant)
		else if(istype(material, /obj/item/stack/sheet))
			if(material.get_amount() < 1)
				to_chat(user, "<span class='warning'>тебе нужен один лист для этого!</span>")
				return
			to_chat(user, "<span class='notice'>You start adding [material] to [src]...</span>")
			if(do_after(user, 20, target = src) && material.use(1))
				var/list/material_list = list()
				if(material.material_type)
					material_list[material.material_type] = MINERAL_MATERIAL_AMOUNT
				make_new_table(/obj/structure/table/greyscale, material_list)
	else
		return ..()

/obj/structure/table_frame/proc/make_new_table(table_type, custom_materials) //makes sure the new table made retains what we had as a frame
	var/obj/structure/table/T = new table_type(loc)
	T.frame = type
	T.framestack = framestack
	T.framestackamount = framestackamount
	if(custom_materials)
		T.set_custom_materials(custom_materials)
	qdel(src)

/obj/structure/table_frame/deconstruct(disassembled = TRUE)
	new framestack(get_turf(src), framestackamount)
	qdel(src)

/obj/structure/table_frame/narsie_act()
	new /obj/structure/table_frame/wood(src.loc)
	qdel(src)

/*
 * Wooden Frames
 */

/obj/structure/table_frame/wood
	name = "деревянная рама стола"
	desc = "Четыре деревянные ножки с четырьмя обрамляющими деревянными стержнями для деревянного стола. Вы могли бы легко пройти через это."
	icon_state = "wood_frame"
	framestack = /obj/item/stack/sheet/mineral/wood
	framestackamount = 2
	resistance_flags = FLAMMABLE

/obj/structure/table_frame/wood/attackby(obj/item/I, mob/user, params)
	if (istype(I, /obj/item/stack))
		var/obj/item/stack/material = I
		var/toConstruct // stores the table variant
		if(istype(I, /obj/item/stack/sheet/mineral/wood))
			toConstruct = /obj/structure/table/wood
		else if(istype(I, /obj/item/stack/tile/carpet))
			toConstruct = /obj/structure/table/wood/poker
		else if(istype(I, /obj/item/stack/sheet/plasteel))
			toConstruct = /obj/structure/table/wood/reinforced

		if (toConstruct)
			if(material.get_amount() < 1)
				to_chat(user, "<span class='warning'>тебе нужен один [material.name] лист, чтобы сделать это!</span>")
				return
			to_chat(user, "<span class='notice'>ты начинаешь добавлять [material] в [src]...</span>")
			if(do_after(user, 20, target = src) && material.use(1))
				make_new_table(toConstruct)
	else
		return ..()
