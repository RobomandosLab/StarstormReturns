local item_sprite = Sprite.new("Roulette", path.combine(PATH, "Sprites/Items/roulette.png"), 1, 16, 11)
local wheel_sprite = Sprite.new("RouletteWheel", path.combine(PATH, "Sprites/Items/Effects/rouletteWheel.png"), 8, 40, 40)
local buffs_sprite = Sprite.new("RouletteBuffs", path.combine(PATH, "Sprites/Buffs/roulette.png"), 7, 8, 8)
local sound = Sound.new("Roulette", path.combine(PATH, "Sounds/Items/roulette.ogg"))

local roulette = Item.new("roulette")

roulette:set_sprite(item_sprite)
roulette:set_tier(ItemTier.UNCOMMON)
roulette.loot_tags = Item.LootTag.CATEGORY_HEALING + Item.LootTag.CATEGORY_DAMAGE + Item.LootTag.CATEGORY_UTILITY

ItemLog.new_from_item(roulette)

local buffMaxHP			= Buff.new("rouletteMaxHP")
local buffRegen			= Buff.new("rouletteRegen")
local buffDamage		= Buff.new("rouletteDamage")
local buffAttackSpeed	= Buff.new("rouletteAttackSpeed")
local buffCritChance	= Buff.new("rouletteCritChance")
local buffMoveSpeed		= Buff.new("rouletteMoveSpeed")
local buffArmor			= Buff.new("rouletteArmor")

local roulette_buffs = {
	buffMaxHP,
	buffRegen,
	buffDamage,
	buffAttackSpeed,
	buffCritChance,
	buffMoveSpeed,
	buffArmor,
}

for i, buff in ipairs(roulette_buffs) do
	buff.icon_sprite = buffs_sprite
	buff.icon_subimage = i - 1
end

local rouletteObject = Object.new("RouletteWheel")
rouletteObject:set_sprite(wheel_sprite)
rouletteObject:set_depth(-1)

local function roulette_roll(actor)
	if Net.client then return end

	local buff_index = math.random(#roulette_buffs)

	local obj = rouletteObject:create(actor.x, actor.bbox_top - 40)
	obj.buff_index = buff_index
	obj.parent = actor
end

local function roulette_clear_buffs(actor)
	for _, buff in ipairs(roulette_buffs) do
		if actor:buff_count(buff) > 0 then
			actor:buff_remove(buff)
		end
	end
end

Callback.add(rouletteObject.on_create, function(self)
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

Callback.add(rouletteObject.on_step, function(self)
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

			if Net.host and self.parent:item_count(roulette) > 0 then
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

Callback.add(roulette.on_acquired, function(actor, stack)
	if stack == 1 then -- first stack gained
		roulette_roll(actor)
	end
end)

Callback.add(roulette.on_removed, function(actor, stack)
	if stack == 1 then -- final stack lost
		roulette_clear_buffs(actor)
	end
end)

Callback.add(Callback.ON_MINUTE, function(minute, second)
	if Net.client then return end

	for _, actor in ipairs(roulette:get_holding_actors()) do
		roulette_roll(actor)
	end
end)

-- -- adjust hp value so the player doesn't have missing hp after the buff
local maxhp_old
local hp_old

Hook.add_pre(gm.constants.recalculate_stats, function(self, other, result, args)
	if self:item_count(roulette) <= 0 then return end
	
	maxhp_old = self.maxhp
	hp_old = self.hp
end)

RecalculateStats.add(function(actor)
	local stack = actor:buff_count(buffMaxHP)
    if stack <= 0 then return end
	
	local item = actor:item_count(roulette)
	actor.maxhp = actor.maxhp + 60 * (0.6 + 0.4 * item)
	
	local hp_restore = hp_old - actor.hp
	actor.hp = math.min(actor.maxhp, actor.hp + math.max(0, actor.maxhp - maxhp_old + hp_restore))
end)

RecalculateStats.add(function(actor)
	local stack = actor:buff_count(buffRegen)
    if stack <= 0 then return end
	
	local item = actor:item_count(roulette)
	actor.hp_regen = actor.hp_regen + 0.06 * (0.6 + 0.4 * item)
end)

RecalculateStats.add(function(actor)
	local stack = actor:buff_count(buffDamage)
    if stack <= 0 then return end
	
	local item = actor:item_count(roulette)
	actor.damage = actor.damage + 14 * (0.6 + 0.4 * item)
end)

RecalculateStats.add(function(actor)
	local stack = actor:buff_count(buffAttackSpeed)
    if stack <= 0 then return end
	
	local item = actor:item_count(roulette)
	actor.attack_speed = actor.attack_speed + 0.35 * (0.6 + 0.4 * item)
end)

RecalculateStats.add(function(actor)
	local stack = actor:buff_count(buffCritChance)
    if stack <= 0 then return end
	
	local item = actor:item_count(roulette)
	actor.critical_chance = actor.critical_chance + 25 * (0.6 + 0.4 * item)
end)

RecalculateStats.add(function(actor)
	local stack = actor:buff_count(buffMoveSpeed)
	if stack <= 0 then return end
	
	local item = actor:item_count(roulette)
	actor.pHmax = actor.pHmax + 0.52 * (0.6 + 0.4 * item)
end)

RecalculateStats.add(function(actor)
	local stack = actor:buff_count(buffArmor)
	if stack <= 0 then return end
	
	local item = actor:item_count(roulette)
	actor.armor = actor.armor + 35 * (0.6 + 0.4 * item)
end)

-- networking
local serializer = function(self, buffer)
	buffer:write_instance(self.parent)
	buffer:write_byte(self.buff_index)
end

local deserializer = function(self, buffer)
	self.parent = buffer:read_instance()
	self.buff_index = buffer:read_byte()
end

Object.add_serializers(rouletteObject, serializer, deserializer)
