

local palette = gm.sprite_add(PATH.."Sprites/Elites/Poison/poisonPalette.png", 1, false, false, 0, 0) --determines the colour of the enemy and stuff, look at vanilla elite palettes for reference (not player palettes, those r different it seems)
local elite_id = gm.elite_type_create("starstorm", "poison")
local elite_class = gm.variable_global_get("class_elite")

--using frenzied elite as a base for a lot of things, i havent looked into it too hard but the class dump is a good reference otherwise
local brainworms = elite_class[3] 
local test_me = elite_class[elite_id+1]
for i = 0, 10, 1 do
    if i > 3 and i ~= 7 then
        gm.array_set(test_me, i-1, brainworms[i])
    end
end
gm.array_set(test_me, 3, palette)
gm.array_set(test_me, 4, palette)
local eliteNate = gm.elite_type_find("poison")

--applying elite types, i sort of took some of this code from blighted worm and modified it
local monster_cards = gm.variable_global_get("class_monster_card") 
for i=1, #monster_cards do
    local card = monster_cards[i]
    local elite_types = gm.array_get(card, 7)
    gm.ds_list_add(elite_types, eliteNate)
end

gm._mod_elite_generate_palette_all()
gm.elite_generate_palettes(elite_id) --havent tested too much, you probably only need one of these instead of both

--custom elite item, ignore this mostly since i havent touched this much. this would probably also be how you handle a lot of the custom behaviour of the elites
--tier is 7, sprite id is 1628, object id is -1, 0 loot tags
local item = Item.create("starstorm", "poisonEliteItem")

Item.add_callback(item, "onPickup", function (actor)
    log.info("Starstorm poison elite item onPickup triggered!!")
end)

Item.add_callback(item, "onStep", function (actor, stack)
    if stack > 0 then
        if not actor.ssr_poison_cooldown then
            log.info("Poison triggered!!")
            actor.ssr_poison_cooldown = 10
            
            -- TODO: Clean up this code
            local t = gm.instance_create(actor.x, actor.y, gm.constants.oMushDust)
            t.parent = actor
            t.team = actor.team
            t.damage = 5 --damage / 3 * (critical + 1)
            --t.critical = critical
		else
			if actor.ssr_poison_cooldown > 0 then
				actor.ssr_poison_cooldown = actor.ssr_poison_cooldown - 1
			else
				actor.ssr_poison_cooldown = nil
			end
		end
        
    end
end)

local id = Item.find("starstorm", "poisonEliteItem")
Callback.add("onEliteInit", "starstorm.elite_init", function (actor)
    --need to maket this apply to blighted too
    if gm.actor_get_elite_type(actor) == elite_id then
        gm.item_give_internal(actor, id, 1, Item.TYPE.real)
    end
end)