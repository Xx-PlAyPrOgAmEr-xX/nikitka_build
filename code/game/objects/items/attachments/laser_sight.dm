/obj/item/attachment/laser_sight
	name = "Лазерный прицел"
	desc = "Предназначен для установки на рельсах совместимого огнестрельного оружия для обеспечения повышенной точности и уменьшения разброса."
	icon_state = "laserpointer"

	attach_features_flags = ATTACH_REMOVABLE_HAND|ATTACH_TOGGLE
	pixel_shift_x = 1
	pixel_shift_y = 4
	wield_delay = 0.1 SECONDS

/obj/item/attachment/laser_sight/toggle_attachment(obj/item/gun/gun, mob/user)
	. = ..()

	if(toggled)
		gun.spread -= 3
		gun.spread_unwielded -= 3
		gun.wield_delay -= 0.3 SECONDS
	else
		gun.spread += 3
		gun.spread_unwielded += 3
		gun.wield_delay += 0.3 SECONDS

	playsound(user, toggled ? 'sound/weapons/magin.ogg' : 'sound/weapons/magout.ogg', 40, TRUE)
