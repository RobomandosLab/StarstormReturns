local item_sprite = Resources.sprite_load(NAMESPACE, "BlastKnuckles", path.combine(PATH, "Sprites/Items/blastKnuckles.png"), 1, 16, 14)
local buff_sprite = Resources.sprite_load(NAMESPACE, "BuffBlastCharge", path.combine(PATH, "Sprites/Buffs/blastCharge.png"), 1, 5, 14)

local RADIUS = 96
local RADIUS_SQUARED = RADIUS * RADIUS

local BLAST_WIDTH = 96
local BLAST_HEIGHT = 20
local BLAST_OFFSET_MARGIN = 1
local BLAST_DAMAGE_COEFFICIENT = 2.2 -- scales off damage stat, not TOTAL damage

local CHARGE_CAPACITY = 5
local CHARGE_INITIAL = 3
local CHARGE_INTERVAL = 3 * 60

local COLOR = Color.from_rgb(76, 128, 86)

local blastKnuckles = Item.new(NAMESPACE, "blastKnuckles")
blastKnuckles:set_sprite(item_sprite)
blastKnuckles:set_tier(Item.TIER.uncommon)
blastKnuckles:set_loot_tags(Item.LOOT_TAG.category_damage)

local buffBlastCharge = Buff.new(NAMESPACE, "blastKnuckles")
buffBlastCharge.is_timed = false
buffBlastCharge.max_stack = CHARGE_CAPACITY
buffBlastCharge.draw_stack_number = true
buffBlastCharge.stack_number_col = Array.new({COLOR})
buffBlastCharge.icon_sprite = buff_sprite
buffBlastCharge.icon_stack_subimage = false

blastKnuckles:clear_callbacks()
blastKnuckles:onAcquire(function(actor, stack)
	actor:buff_apply(buffBlastCharge, 60, CHARGE_INITIAL)
end)

-- uses `__ssr_blasted` magic variable to mark the attack_info to prevent one attack from firing more than one blast
blastKnuckles:onHitProc(function(actor, victim, stack, hit_info)
	if hit_info.attack_info.__ssr_blasted then return end

	local dx = hit_info.x - actor.x
	local dy = hit_info.y - actor.y
	if (dx * dx + dy * dy) <= RADIUS_SQUARED and actor:buff_stack_count(buffBlastCharge) > 0 then
		local attack_info = hit_info.attack_info
		attack_info.__ssr_blasted = true

		actor:buff_remove(buffBlastCharge, 1)
		gm.sound_play_networked(gm.constants.wExplosiveShot, 1.0, 1.2, victim.x, victim.y)

		-- calculate the blast's location, such that it
		local width = victim.bbox_right - victim.bbox_left
		local x_origin = (victim.bbox_right + victim.bbox_left) * 0.5 -- centre of victim based on collision, accounts for offset
		local attack_vector = gm.lengthdir_x(1, attack_info.direction)
		attack_vector = gm.sign(attack_vector)

		local knockback_compensate = 0
		if GM.actor_is_classic(victim) then
			-- compensate for 1-frame delay to attack processing so the blast doesn't hit the victim when they're knocked back
			knockback_compensate = attack_info.knockback * 2 + attack_info.stun * 20

			-- compensate for stagger
			if hit_info.damage > victim.knockback_cap then
				knockback_compensate = knockback_compensate + 6
			end
		end
		local offset = (0.5 * (width + BLAST_WIDTH) + BLAST_OFFSET_MARGIN + knockback_compensate) * attack_vector

		local blast = actor:fire_explosion(x_origin + offset, hit_info.y, BLAST_WIDTH, BLAST_HEIGHT, BLAST_DAMAGE_COEFFICIENT * stack, gm.constants.sBanditShoot2Explosion, nil, false).attack_info
		blast.direction = hit_info.direction
		blast.damage_color = COLOR
		blast.knockback_direction = attack_info.knockback_direction
		blast.climb = hit_info.attack_info.climb + 8 * 1.35
	end
end)

blastKnuckles:onPostStep(function(actor, stack)
	if gm._mod_net_isClient() then return end
	if Global._current_frame % CHARGE_INTERVAL == 0 then
		actor:buff_apply(buffBlastCharge, 60, 1)
	end
end)

blastKnuckles:onPostDraw(function(actor, stack)
	local alpha = 0.65 + math.sin(Global._current_frame*0.03) * 0.1
	local x, y = actor.ghost_x, actor.ghost_y
	local charges = actor:buff_stack_count(buffBlastCharge)

	if charges == 0 then
		alpha = alpha * 0.5
	end

	gm.draw_set_alpha(alpha)
	gm.draw_set_colour(COLOR)
	gm.draw_circle(actor.ghost_x, actor.ghost_y, RADIUS, true)
	gm.draw_set_alpha(1)
end)
