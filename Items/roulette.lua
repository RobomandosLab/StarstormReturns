local item_sprite = Resources.sprite_load(NAMESPACE, "Roulette", path.combine(PATH, "Sprites/Items/roulette.png"), 1, 16, 16)
local sound = Resources.sfx_load(NAMESPACE, "Roulette", path.combine(PATH, "Sounds/Items/roulette.ogg"))
local wheel_sprite = Resources.sprite_load(NAMESPACE, "RouletteWheel", path.combine(PATH, "Sprites/Items/Effects/rouletteWheel.png"), 8, 40, 40)

local roulette = Item.new(NAMESPACE, "roulette")
roulette:set_sprite(item_sprite)
roulette:set_tier(Item.TIER.uncommon)
roulette:set_loot_tags(	Item.LOOT_TAG.category_healing,
						Item.LOOT_TAG.category_damage,
						Item.LOOT_TAG.category_utility)

local roulette_buffs = {
	{variable = "maxhp",			value = 60,		stack = 24},
	{variable = "hp_regen",			value = 0.06,	stack = 0.03},
	{variable = "damage",			value = 14,		stack = 5},
	{variable = "attack_speed",		value = 0.35,	stack = 0.155},
	{variable = "critical_chance",	value = 22,		stack = 9},
	{variable = "pHmax",			value = 0.52,	stack = 0.2},
	{variable = "armor",			value = 34,		stack = 13},
}

local rouletteObject = Object.new(NAMESPACE, "RouletteWheel")

local function roulette_roll(actor)
	if gm._mod_net_isClient() then return end

	local buff_index = math.random(#roulette_buffs)

	local obj = rouletteObject:create(actor.x, actor.bbox_top - 80)
	obj.buff_index = buff_index
	obj.parent = actor
end

roulette:clear_callbacks()
roulette:onPickup(function(actor, stack)
	local data = actor:get_data()
	if not data.roulette_buff_index then
		data.roulette_buff_index = 0

		roulette_roll(actor)
	end
end)
roulette:onRemove(function(actor, stack)
	if stack == 1 then
		actor:get_data().roulette_buff_index = nil
	end
end)

roulette:onStatRecalc(function(actor, stack)
	local index = actor:get_data().roulette_buff_index
	local buff = roulette_buffs[index]

	if buff then
		local increase = buff.value + buff.stack * (stack - 1)
		actor[buff.variable] = actor[buff.variable] + increase
	end
end)

Callback.add("onMinute", "SSRouletteReroll", function()
	if gm._mod_net_isClient() then return end

	local actors = Instance.find_all(gm.constants.pActor)

	for _, actor in ipairs(actors) do
		local stack = actor:item_stack_count(roulette)
		if stack > 0 then
			roulette_roll(actor)
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
end)
rouletteObject:onStep(function(self)
	if not Instance.exists(self.parent) then
		self:destroy()
		return
	end

	self.timer = self.timer + 1

	if self.timer < 40 then
		self.rspeed = self.rspeed * 1.1
		self.image_angle = self.image_angle + self.rspeed
	else
		if not self.trigger then
			self.trigger = true
			self.image_angle = 0
			self.image_index = self.buff_index
			self.vspeed = -0.1

			self.parent:get_data().roulette_buff_index = self.buff_index
			self.parent:recalculate_stats()
		end
		self.image_alpha = self.image_alpha - 0.01

		if self.image_alpha <= 0 then
			self:destroy()
		end
	end

end)
