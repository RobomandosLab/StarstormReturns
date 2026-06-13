-- THIS NEEDS A PROPER CLASS ASAP
-- I am not familiar with building out a proper class, and that is just not what im trying to look at rn
-- I'm mainly messing with mechanics rn to see what's possible

-- WHAT THIS PROBABLY NEEDS TO WORK
-- GENERAL: if we use anything normal items do like pickups, wed need to make sure to alter behaviors related to items
-- Having .find() and whatnot like the RAPI classes is probably a good idea, generally making this work like RAPI is good
-- Giving actors some kind of :memento_set() and :memento_get() like equipments would be cool obvs
Memento = {}

pPickupMemento = Object.new("pPickupMemento", Global.pPickup)

Memento.new = function(identifier)
    Memento[identifier] = {}
    -- theres functions here that the game uses to register objects and stuff
    -- ideally we get to a point where we can call gm.item_drop_object() and it spawns a pickup parented to pPickupMemento
end