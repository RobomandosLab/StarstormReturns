local mementoPickup = Object.find("pPickupMemento")

Callback.add(Callback.ON_KILL_PROC, function(actor) 
    print("what is this even bro")
    Instance.create(actor.x, actor.y, mementoPickup)
end)

