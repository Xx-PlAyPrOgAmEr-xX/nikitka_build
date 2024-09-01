/*
CONTAINS:
BEDSHEETS
LINEN BINS
*/

/obj/item/bedsheet
	name = "простыня"
	desc = "Удивительно мягкая простыня."
	icon = 'icons/obj/bedsheets.dmi'
	lefthand_file = 'icons/mob/inhands/misc/bedsheet_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/bedsheet_righthand.dmi'
	icon_state = "sheetwhite"
	item_state = "sheetwhite"
	slot_flags = ITEM_SLOT_NECK
	layer = MOB_LAYER
	throwforce = 0
	throw_speed = 1
	throw_range = 2
	w_class = WEIGHT_CLASS_TINY
	resistance_flags = FLAMMABLE
	dying_key = DYE_REGISTRY_BEDSHEET
	greyscale_icon_state = "bedsheet"
	greyscale_colors = list(list(11, 15), list(16, 4), list(16,22))

	dog_fashion = /datum/dog_fashion/head/ghost
	var/list/dream_messages = list("white")

/obj/item/bedsheet/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/bed_tuckable, 0, 0, 0)

/obj/item/bedsheet/attack_self(mob/user)
	if(!user.CanReach(src))		//No telekenetic grabbing.
		return
	if(!user.dropItemToGround(src))
		return
	if(layer == initial(layer))
		layer = ABOVE_MOB_LAYER
		to_chat(user, "<span class='notice'>Ты прикрываешься [src].</span>")
		pixel_x = 0
		pixel_y = 0
	else
		layer = initial(layer)
		to_chat(user, "<span class='notice'>Ты гладкий [src] под собой.</span>")
	add_fingerprint(user)
	return

/obj/item/bedsheet/attackby(obj/item/I, mob/user, params)
	if(I.tool_behaviour == TOOL_WIRECUTTER || I.get_sharpness())
		var/obj/item/stack/sheet/cotton/cloth/shreds = new (get_turf(src), 3)
		if(!QDELETED(shreds)) //stacks merged
			transfer_fingerprints_to(shreds)
			shreds.add_fingerprint(user)
		qdel(src)
		to_chat(user, "<span class='notice'>Ты разрываешь [src] вверх.</span>")
	else
		return ..()

/obj/item/bedsheet/blue
	icon_state = "sheetblue"
	item_state = "sheetblue"
	dream_messages = list("blue")

/obj/item/bedsheet/green
	icon_state = "sheetgreen"
	item_state = "sheetgreen"
	dream_messages = list("green")

/obj/item/bedsheet/grey
	icon_state = "sheetgrey"
	item_state = "sheetgrey"
	dream_messages = list("grey")

/obj/item/bedsheet/orange
	icon_state = "sheetorange"
	item_state = "sheetorange"
	dream_messages = list("orange")

/obj/item/bedsheet/purple
	icon_state = "sheetpurple"
	item_state = "sheetpurple"
	dream_messages = list("purple")

/obj/item/bedsheet/patriot
	name = "патриотическая простыня"
	desc = "Ты никогда не чувствовал себя более свободным, чем когда спал на этом."
	icon_state = "sheetUSA"
	item_state = "sheetUSA"
	dream_messages = list("Америка", "свобода", "фейверк", "лысые яйца")

/obj/item/bedsheet/rainbow
	name = "радужная простыня"
	desc = "Разноцветное одеяло. На самом деле это несколько разных простыней, разрезанных и сшитых вместе."
	icon_state = "sheetrainbow"
	item_state = "sheetrainbow"
	dream_messages = list("красное", "оранжевое", "жёлтое", "зёленое", "синие", "фиолетовое", "и радужное")

/obj/item/bedsheet/red
	icon_state = "sheetred"
	item_state = "sheetred"
	dream_messages = list("red")

/obj/item/bedsheet/yellow
	icon_state = "sheetyellow"
	item_state = "sheetyellow"
	dream_messages = list("yellow")

/obj/item/bedsheet/mime
	name = "одеяло мима"
	desc = "Очень успокаивающее полосатое одеяло. Кажется, что весь шум стихает, когда ты лежишь под одеялом."
	icon_state = "sheetmime"
	item_state = "sheetmime"
	dream_messages = list("тишина", "жесты", "бледное лицо", "разинутый рот", "мим")

/obj/item/bedsheet/clown
	name = "клоунское одеяло"
	desc = "Радужное покрывало с вплетенной в него маской клоуна. Оно слегка пахнет бананами."
	icon_state = "sheetclown"
	item_state = "sheetrainbow"
	dream_messages = list("хонк", "смех", "пранк", "шутка", "улыбающиеся лицо", "клоун")

/obj/item/bedsheet/captain
	name = "капитанская простыня"
	desc = "На нем нанесен символ Nanotrasen, и он был соткан из революционно нового вида нитей, которые гарантированно обладают проницаемостью 0,01% для большинства нехимических веществ, популярных среди большинства современных капитанов."
	icon_state = "sheetcaptain"
	item_state = "sheetcaptain"
	dream_messages = list("authority", "золотая айди-карта", "солнечные очки", "ядерный диск", "антикварное оружие", "капитан")

/obj/item/bedsheet/rd
	name = "простыня директора по исследованиям"
	desc = "На нем, похоже, изображена эмблема мензурки, и он сделан из огнеупорного материала, хотя, вероятно, он не защитит вас в случае пожаров, с которыми вы сталкиваетесь каждый день."
	icon_state = "sheetrd"
	item_state = "sheetrd"
	dream_messages = list("власть", "серебренное", "бомба", "экзокостюм", "лицехват", "маниакальный смех", "директор по исследованиям")

/obj/item/bedsheet/medical
	name = "медицинское одеяло"
	desc = "Это стерилизованное* одеяло, обычно используемое в медицинском отделении. * Стерилизация аннулируется, если вирусолог находится в радиусе 10 метров*."
	icon_state = "sheetmedical"
	item_state = "sheetmedical"
	dream_messages = list("лечение", "жизнь", "хиррургия", "врач")

/obj/item/bedsheet/cmo
	name = "простыня главного врача"
	desc = "Это простерилизованное одеяло с эмблемой в виде креста. На нем немного кошачьей шерсти, вероятно, оставшейся со времен эксплуатации."
	icon_state = "sheetcmo"
	item_state = "sheetcmo"
	dream_messages = list("власть", "серебристое удостоверение личности", "лечение", "жизнь", "хиррургия", "кот", "главный врач")

/obj/item/bedsheet/hos
	name = "простыня начальника службы безопасности"
	desc = "Он украшен эмблемой в виде щита. Пока преступность не дремлет, дремлете вы, но ЗАКОН по-прежнему представляете вы!"
	icon_state = "sheethos"
	item_state = "sheethos"
	dream_messages = list("власть", "серебрянное айди-карта", "наручники", "дубинка", "светашумовая", "солнечные очки", "начальник службы безопасности")

/obj/item/bedsheet/head_of_personnel
	name = "простыня руководителя отдела кадров"
	desc = "Он украшен эмблемой key. Для тех редких моментов, когда вы можете отдохнуть и обняться с Яном без того, чтобы кто-то звал вас по радио.."
	icon_state = "sheethop"
	item_state = "sheethop"
	dream_messages = list("authority", "a silvery ID", "obligation", "a computer", "an ID", "a corgi", "the head of personnel")

/obj/item/bedsheet/ce
	name = "простыня начальника инженерного отсека"
	desc = "Он украшен эмблемой с гаечным ключом. Он обладает высокой светоотражающей способностью и устойчив к образованию пятен, поэтому вам не нужно беспокоиться о том, что он может испачкаться маслом."
	icon_state = "sheetce"
	item_state = "sheetce"
	dream_messages = list("власть", "серебряннае айди-карта", "двигатель", "инструменты", "АПЦ", "попугай", "начальник инженерии")

/obj/item/bedsheet/qm
	name = "простыня квартирмейстера"
	desc = "It is decorated with a crate emblem in silver lining.  It's rather tough, and just the thing to lie on after a hard day of pushing paper."
	icon_state = "sheetqm"
	item_state = "sheetqm"
	dream_messages = list("серая айди-карта", "шаттл", "ящик", "слот", "квартирмейстер")

/obj/item/bedsheet/chaplain
	name = "простыня священника"
	desc = "Покрывало, сотканное из сердец самих богов... Подождите, это же просто лен."
	icon_state = "sheetchap"
	item_state = "sheetchap"
	dream_messages = list("серая айди-карта", "боги", "исполненная молитва", "культ", "священник")

/obj/item/bedsheet/brown
	icon_state = "sheetbrown"
	item_state = "sheetbrown"
	dream_messages = list("brown")

/obj/item/bedsheet/black
	icon_state = "sheetblack"
	item_state = "sheetblack"
	dream_messages = list("black")

/obj/item/bedsheet/centcom
	name = "\improper простыня Цент-кома"
	desc = "Сотканный из современных нанопрядей для придания тепла, а также очень декоративный, он незаменим для всех чиновников.."
	icon_state = "sheetcentcom"
	item_state = "sheetcentcom"
	dream_messages = list("уникальный идентификатор", "власть", "артиллерия ", "окончание")

/obj/item/bedsheet/syndie
	name = "синдикатная простыня"
	desc = "На нем эмблема синдиката, и от него исходит аура зла."
	icon_state = "sheetsyndie"
	item_state = "sheetsyndie"
	dream_messages = list("ядерный диск", "крастный кристалл", "светящийся клинок", "удостоверение личности, покрытое проволокой")

/obj/item/bedsheet/cult
	name = "простыня культа"
	desc = "Тебе может присниться Нарси, если ты будешь спать с этим. Он выглядит довольно потрепанным и излучает сверхъестественное присутствие."
	icon_state = "sheetcult"
	item_state = "sheetcult"
	dream_messages = list("том", "парящий красный кристалл", "светящийся меч", "кровавый символ", "массивная человекоподобная фигура")

/obj/item/bedsheet/wiz
	name = "простыня магов"
	desc = "Специальная ткань, пропитанная магией, подарит вам волшебную ночь. Она даже светится!"
	icon_state = "sheetwiz"
	item_state = "sheetwiz"
	dream_messages = list("книга", "взрыв", "молния", "посох", "скелет", "роба", "магия")

/obj/item/bedsheet/nanotrasen
	name = "\improper простыня нанотрейзен"
	desc = "На нем изображен логотип Nanotrasen, и от него исходит аура долга."
	icon_state = "sheetNT"
	item_state = "sheetNT"
	dream_messages = list("власть", "конец")

/obj/item/bedsheet/solgov
	name = "\improper Простыня SolGov"
	desc = "На нем изображена эмблема Солнечной конфедерации!"
	icon_state = "sheetsolgov"
	item_state = "sheetsolgov"
	dream_messages = list("бюрократия", "законы", "бумага", "пишу")

/obj/item/bedsheet/suns
	name = "\improper SUNS простыня"
	desc = "Пурпурно-золотая простыня со значком СОЛНЦА на ней."
	icon_state = "sheetsuns"
	item_state = "sheetsuns"
	dream_messages = list("чтение", "наука", "геология", "учеба за день до экзамена")

/obj/item/bedsheet/ian
	icon_state = "sheetian"
	item_state = "sheetian"
	dream_messages = list("собака", "корги", "вуф", "гаф", "арф")

/obj/item/bedsheet/cosmos
	name = "космическая постель"
	desc = "Созданный из мечтаний тех, кто смотрит на звезды.."
	icon_state = "sheetcosmos"
	item_state = "sheetcosmos"
	dream_messages = list("the infinite cosmos", "Hans Zimmer music", "a flight through space", "the galaxy", "being fabulous", "shooting stars")
	light_power = 2
	light_range = 1.4

/obj/item/bedsheet/random
	icon_state = "random_bedsheet"
	name = "random bedsheet"
	desc = "If you're reading this description ingame, something has gone wrong! Honk!"

/obj/item/bedsheet/double
	icon_state = "double_sheetwhite"
	dying_key = DYE_REGISTRY_DOUBLE_BEDSHEET

/obj/item/bedsheet/double/Initialize()
	. = ..()
	desc += " This one is double-sized."

/obj/item/bedsheet/double/blue
	icon_state = "double_sheetblue"
	item_state = "sheetblue"
	dream_messages = list("blue")

/obj/item/bedsheet/double/green
	icon_state = "double_sheetgreen"
	item_state = "sheetgreen"
	dream_messages = list("green")

/obj/item/bedsheet/double/grey
	icon_state = "double_sheetgrey"
	item_state = "sheetgrey"
	dream_messages = list("grey")

/obj/item/bedsheet/double/orange
	icon_state = "double_sheetorange"
	item_state = "sheetorange"
	dream_messages = list("orange")

/obj/item/bedsheet/double/purple
	icon_state = "double_sheetpurple"
	item_state = "sheetpurple"
	dream_messages = list("purple")

/obj/item/bedsheet/double/red
	icon_state = "double_sheetred"
	item_state = "sheetred"
	dream_messages = list("red")

/obj/item/bedsheet/double/yellow
	icon_state = "double_sheetyellow"
	item_state = "sheetyellow"
	dream_messages = list("yellow")

/obj/item/bedsheet/double/brown
	icon_state = "double_sheetbrown"
	item_state = "sheetbrown"
	dream_messages = list("говно")

/obj/item/bedsheet/double/black
	icon_state = "double_sheetblack"
	item_state = "sheetblack"
	dream_messages = list("black")

/obj/item/bedsheet/double/patriot
	name = "double patriotic bedsheet"
	icon_state = "double_sheetUSA"
	item_state = "sheetUSA"
	dream_messages = list("America", "freedom", "fireworks", "bald eagles")
	desc = "You've never felt more free than when sleeping on this."

/obj/item/bedsheet/double/rainbow
	name = "double rainbow bedsheet"
	icon_state = "double_sheetrainbow"
	item_state = "sheetrainbow"
	dream_messages = list("red", "orange", "yellow", "green", "blue", "purple", "a rainbow")
	desc = "A multicolored blanket. It's actually several different sheets cut up and sewn together."

/obj/item/bedsheet/double/mime
	name = "double mime's blanket"
	icon_state = "double_sheetmime"
	item_state = "sheetmime"
	dream_messages = list("silence", "gestures", "a pale face", "a gaping mouth", "the mime")
	desc = "A very soothing striped blanket.  All the noise just seems to fade out when you're under the covers in this."

/obj/item/bedsheet/double/clown
	name = "double clown's blanket"
	icon_state = "double_sheetclown"
	item_state = "sheetrainbow"
	dream_messages = list("honk", "laughter", "a prank", "a joke", "a smiling face", "the clown")
	desc = "A rainbow blanket with a clown mask woven in. It smells faintly of bananas."

/obj/item/bedsheet/double/captain
	name = "double captain's bedsheet"
	icon_state = "double_sheetcaptain"
	item_state = "sheetcaptain"
	dream_messages = list("authority", "a golden ID", "sunglasses", "a green disc", "an antique gun", "the captain")
	desc = "It has a Nanotrasen symbol on it, and was woven with a revolutionary new kind of thread guaranteed to have 0.01% permeability for most non-chemical substances, popular among most modern captains."

/obj/item/bedsheet/double/rd
	name = "double research director's bedsheet"
	icon_state = "double_sheetrd"
	item_state = "sheetrd"
	dream_messages = list("authority", "a silvery ID", "a bomb", "an exosuit", "a facehugger", "maniacal laughter", "the research director")
	desc = "It appears to have a beaker emblem, and is made out of fire-resistant material, although it probably won't protect you in the event of fires you're familiar with every day."

/obj/item/bedsheet/double/solgov
	name = "double SolGov bedsheet"
	icon_state = "double_sheetsolgov"
	item_state = "double_sheetsolgov"
	dream_messages = list("bureaucracy", "laws", "papers", "writing")
	desc = "It has the emblem of the Solar Confederation emblazoned upon it!"

/obj/item/bedsheet/double/suns
	name = "double SUNS bedsheet"
	desc = "A large gold and purple bedsheet with the SUNS icon on it."
	icon_state = "double_sheetsuns"
	item_state = "double_sheetsuns"
	dream_messages = list("learning", "science", "geology", "studying a day before an exam")

/obj/item/bedsheet/random/Initialize()
	..()
	var/type = pick(typesof(/obj/item/bedsheet) - (typesof(/obj/item/bedsheet/double) + /obj/item/bedsheet/random))
	new type(loc)
	return INITIALIZE_HINT_QDEL

/obj/item/bedsheet/dorms
	icon_state = "random_bedsheet"
	name = "random dorms bedsheet"
	desc = "If you're reading this description ingame, something has gone wrong! Honk!"

/obj/item/bedsheet/dorms/Initialize()
	..()
	var/type = pickweight(list("Colors" = 80, "Special" = 20))
	switch(type)
		if("Colors")
			type = pick(list(/obj/item/bedsheet,
				/obj/item/bedsheet/blue,
				/obj/item/bedsheet/green,
				/obj/item/bedsheet/grey,
				/obj/item/bedsheet/orange,
				/obj/item/bedsheet/purple,
				/obj/item/bedsheet/red,
				/obj/item/bedsheet/yellow,
				/obj/item/bedsheet/brown,
				/obj/item/bedsheet/black))
		if("Special")
			type = /obj/item/bedsheet/rainbow
	new type(loc)
	return INITIALIZE_HINT_QDEL

/obj/item/bedsheet/dorms/double
	icon_state = "double_sheetrainbow"
	name = "random dorms double bedsheet"
	desc = "If you're reading this description ingame, something has gone wrong! Honk!"

/obj/item/bedsheet/dorms/double/Initialize()
	..()
	var/type = pickweight(list("Colors" = 80, "Special" = 20))
	switch(type)
		if("Colors")
			type = pick(list(/obj/item/bedsheet/double,
				/obj/item/bedsheet/double/blue,
				/obj/item/bedsheet/double/green,
				/obj/item/bedsheet/double/grey,
				/obj/item/bedsheet/double/orange,
				/obj/item/bedsheet/double/purple,
				/obj/item/bedsheet/double/red,
				/obj/item/bedsheet/double/yellow,
				/obj/item/bedsheet/double/brown,
				/obj/item/bedsheet/double/black))
		if("Special")
			type = /obj/item/bedsheet/double/rainbow
	new type(loc)
	return INITIALIZE_HINT_QDEL

/obj/structure/bedsheetbin
	name = "linen bin"
	desc = "It looks rather cosy."
	icon = 'icons/obj/structures.dmi'
	icon_state = "linenbin-full"
	anchored = TRUE
	resistance_flags = FLAMMABLE
	max_integrity = 70
	var/amount = 10
	var/list/sheets = list()
	var/obj/item/hidden = null

/obj/structure/bedsheetbin/empty
	amount = 0
	icon_state = "linenbin-empty"
	anchored = FALSE


/obj/structure/bedsheetbin/examine(mob/user)
	. = ..()
	if(amount < 1)
		. += "There are no bed sheets in the bin."
	else if(amount == 1)
		. += "There is one bed sheet in the bin."
	else
		. += "There are [amount] bed sheets in the bin."


/obj/structure/bedsheetbin/update_icon_state()
	switch(amount)
		if(0)
			icon_state = "linenbin-empty"
		if(1 to 5)
			icon_state = "linenbin-half"
		else
			icon_state = "linenbin-full"
	return ..()

/obj/structure/bedsheetbin/fire_act(exposed_temperature, exposed_volume)
	if(amount)
		amount = 0
		update_appearance()
	..()

/obj/structure/bedsheetbin/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/bedsheet))
		if(!user.transferItemToLoc(I, src))
			return
		sheets.Add(I)
		amount++
		to_chat(user, "<span class='notice'>You put [I] in [src].</span>")
		update_appearance()

	else if(default_unfasten_wrench(user, I, 5))
		return

	else if(I.tool_behaviour == TOOL_SCREWDRIVER)
		if(flags_1 & NODECONSTRUCT_1)
			return
		if(amount)
			to_chat(user, "<span clas='warn'>The [src] must be empty first!</span>")
			return
		if(I.use_tool(src, user, 5, volume=50))
			to_chat(user, "<span clas='notice'>You disassemble the [src].</span>")
			new /obj/item/stack/rods(loc, 2)
			qdel(src)

	else if(amount && !hidden && I.w_class < WEIGHT_CLASS_BULKY)	//make sure there's sheets to hide it among, make sure nothing else is hidden in there.
		if(!user.transferItemToLoc(I, src))
			to_chat(user, "<span class='warning'>\The [I] is stuck to your hand, you cannot hide it among the sheets!</span>")
			return
		hidden = I
		to_chat(user, "<span class='notice'>You hide [I] among the sheets.</span>")


/obj/structure/bedsheetbin/attack_paw(mob/user)
	return attack_hand(user)

/obj/structure/bedsheetbin/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	if(isliving(user))
		var/mob/living/L = user
		if(!(L.mobility_flags & MOBILITY_PICKUP))
			return
	if(amount >= 1)
		amount--

		var/obj/item/bedsheet/B
		if(sheets.len > 0)
			B = sheets[sheets.len]
			sheets.Remove(B)

		else
			B = new /obj/item/bedsheet(loc)

		B.forceMove(drop_location())
		user.put_in_hands(B)
		to_chat(user, "<span class='notice'>You take [B] out of [src].</span>")
		update_appearance()

		if(hidden)
			hidden.forceMove(drop_location())
			to_chat(user, "<span class='notice'>[hidden] falls out of [B]!</span>")
			hidden = null


	add_fingerprint(user)
/obj/structure/bedsheetbin/attack_tk(mob/user)
	if(amount >= 1)
		amount--

		var/obj/item/bedsheet/B
		if(sheets.len > 0)
			B = sheets[sheets.len]
			sheets.Remove(B)

		else
			B = new /obj/item/bedsheet(loc)

		B.forceMove(drop_location())
		to_chat(user, "<span class='notice'>You telekinetically remove [B] from [src].</span>")
		update_appearance()

		if(hidden)
			hidden.forceMove(drop_location())
			hidden = null


	add_fingerprint(user)
