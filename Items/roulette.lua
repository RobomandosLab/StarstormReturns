local item_sprite = Resources.sprite_load(NAMESPACE, "Roulette", path.combine(PATH, "Sprites/Items/roulette.png"), 1, 16, 11)
local wheel_sprite = Resources.sprite_load(NAMESPACE, "RouletteWheel", path.combine(PATH, "Sprites/Items/Effects/rouletteWheel.png"), 8, 40, 40)
local buffs_sprite = Resources.sprite_load(NAMESPACE, "RouletteBuffs", path.combine(PATH, "Sprites/Buffs/roulette.png"), 7, 8, 8)

local sound = Resources.sfx_load(NAMESPACE, "Roulette", path.combine(PATH, "Sounds/Items/roulette.ogg"))

local roulette = Item.new(NAMESPACE, "roulette")
roulette:set_sprite(item_sprite)
roulette:set_tier(Item.TIER.uncommon)
roulette:set_loot_tags(	Item.LOOT_TAG.category_healing,
						Item.LOOT_TAG.category_damage,
						Item.LOOT_TAG.category_utility)

local buffMaxHP			= Buff.new(NAMESPACE, "rouletteMaxHP")
local buffRegen			= Buff.new(NAMESPACE, "rouletteRegen")
local buffDamage		= Buff.new(NAMESPACE, "rouletteDamage")
local buffAttackSpeed	= Buff.new(NAMESPACE, "rouletteAttackSpeed")
local buffCritChance	= Buff.new(NAMESPACE, "rouletteCritChance")
local buffMoveSpeed		= Buff.new(NAMESPACE, "rouletteMoveSpeed")
local buffArmor			= Buff.new(NAMESPACE, "rouletteArmor")

local roulette_buffs = {
	buffMaxHP,
	buffRegen,
	buffDamage,
	buffAttackSpeed,
	buffCritChance,
	buffMoveSpeed,
	buffArmor,
}

local rouletteObject = Object.new(NAMESPACE, "RouletteWheel")

local function roulette_roll(actor)
	if gm._mod_net_isClient() then return end

	local buff_index = math.random(#roulette_buffs)

	local obj = rouletteObject:create(actor.x, actor.bbox_top - 40)
	obj.buff_index = buff_index
	obj.parent = actor
end

local function roulette_clear_buffs(actor)
	for _, buff in ipairs(roulette_buffs) do
		if actor:buff_stack_count(buff) > 0 then
			actor:buff_remove(buff)
		end
	end
end

roulette:clear_callbacks()
roulette:onAcquire(function(actor, stack)
	if stack == 1 then -- first stack gained
		roulette_roll(actor)
	end
end)
roulette:onRemove(function(actor, stack)
	if stack == 1 then -- final stack lost
		roulette_clear_buffs(actor)
	end
end)

Callback.add(Callback.TYPE.onMinute, "SSRouletteReroll", function(_, _)
	if gm._mod_net_isClient() then return end

	local actors = Instance.find_all(gm.constants.pActor)

	for _, actor in ipairs(actors) do
		if GM.actor_is_alive(actor) then
			local stack = actor:item_stack_count(roulette)
			if stack > 0 then
				roulette_roll(actor)
			end
		end
	end
end)

rouletteObject.obj_sprite = wheel_sprite
rouletteObject.obj_depth = -1

rouletteObject:clear_callbacks()
rouletteObject:onCreate(function(self)
	self.image_index = 0
	self.image_speed = 0
	self.persistent = true

	self.buff_index = 0
	self.timer = 0
	self.rspeed = 1
	self.parent = -4

	self:sound_play(sound, 1, 1)
	self:instance_sync()
end)
rouletteObject:onStep(function(self)
	if not Instance.exists(self.parent) then
		self:destroy()
		return
	end

	self.timer = self.timer + 1

	if self.timer < 45 then
		self.rspeed = self.rspeed * 1.1
		self.image_angle = self.image_angle + self.rspeed
	else
		if not self.trigger then
			self.trigger = true
			self.image_angle = 0
			self.image_index = self.buff_index
			self.vspeed = -0.1

			if gm._mod_net_isHost() and self.parent:item_stack_count(roulette) > 0 then
				roulette_clear_buffs(self.parent)

				local new_buff = roulette_buffs[self.buff_index]
				if new_buff then
					self.parent:buff_apply(new_buff, 60 * 60)
				end
			end
		end
		self.image_alpha = self.image_alpha - 0.01

		if self.image_alpha <= 0 then
			self:destroy()
		end
	end
end)
rouletteObject:onSerialize(function(self, buffer)
	buffer:write_instance(self.parent)
	buffer:write_byte(self.buff_index)
end)
rouletteObject:onDeserialize(function(self, buffer)
	self.parent = buffer:read_instance()
	self.buff_index = buffer:read_byte()
end)

for i, buff in ipairs(roulette_buffs) do
	buff.icon_sprite = buffs_sprite
	buff.icon_subimage = i-1
	buff:clear_callbacks()
end

-- adjust hp value so the player doesn't have missing hp after the buff
-- TODO: this should really be the toolkit's problem, not ours.
local maxhp_old
local hp_old
gm.pre_script_hook(gm.constants.recalculate_stats, function(self, other, result, args)
	maxhp_old = self.maxhp
	hp_old = self.hp
end)

buffMaxHP:onStatRecalc(function(actor)
	local stack = actor:item_stack_count(roulette)
	actor.maxhp = actor.maxhp + 60 * (0.6 + 0.4 * stack)

	local hp_restore = hp_old - actor.hp
	actor.hp = math.min(actor.maxhp, actor.hp + math.max(0, actor.maxhp - maxhp_old + hp_restore))
end)

buffRegen:onStatRecalc(function(actor)
	local stack = actor:item_stack_count(roulette)
	actor.hp_regen = actor.hp_regen + 0.06 * (0.6 + 0.4 * stack)
end)

buffDamage:onStatRecalc(function(actor)
	local stack = actor:item_stack_count(roulette)
	actor.damage = actor.damage + 14 * (0.6 + 0.4 * stack)
end)

buffAttackSpeed:onStatRecalc(function(actor)
	local stack = actor:item_stack_count(roulette)
	actor.attack_speed = actor.attack_speed + 0.35 * (0.6 + 0.4 * stack)
end)

buffCritChance:onStatRecalc(function(actor)
	local stack = actor:item_stack_count(roulette)
	actor.critical_chance = actor.critical_chance + 25 * (0.6 + 0.4 * stack)
end)

buffMoveSpeed:onStatRecalc(function(actor)
	local stack = actor:item_stack_count(roulette)
	actor.pHmax = actor.pHmax + 0.52 * (0.6 + 0.4 * stack)
end)

buffArmor:onStatRecalc(function(actor)
	local stack = actor:item_stack_count(roulette)
	actor.armor = actor.armor + 35 * (0.6 + 0.4 * stack)
end)
