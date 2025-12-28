if HOTLOADING then return end
if not ssr_chirrsmas_active then return end -- christmas lasts from december 15th to january 15th
if Settings.chirrsmas == 2 then return end -- if chirrsmas is disabled in the config then we dont do anything

gm.sprite_replace(gm.constants.sGolemIdle, path.combine(PATH, "Sprites/Actors/ChirrsmasGolem/idle.png"), 36, false, false, 26, 35)
gm.sprite_replace(gm.constants.sGolemWalk, path.combine(PATH, "Sprites/Actors/ChirrsmasGolem/walk.png"), 8, false, false, 27, 33)
gm.sprite_replace(gm.constants.sGolemShoot1, path.combine(PATH, "Sprites/Actors/ChirrsmasGolem/attack.png"), 13, false, false, 55, 54)
gm.sprite_replace(gm.constants.sGolemSpawn, path.combine(PATH, "Sprites/Actors/ChirrsmasGolem/spawn.png"), 19, false, false, 43, 99)
gm.sprite_replace(gm.constants.sGolemDeath, path.combine(PATH, "Sprites/Actors/ChirrsmasGolem/death.png"), 16, false, false, 60, 51)
gm.sprite_replace(gm.constants.sGolemJump, path.combine(PATH, "Sprites/Actors/ChirrsmasGolem/jump.png"), 1, false, false, 32, 34)
gm.sprite_replace(gm.constants.sGolemJumpPeak, path.combine(PATH, "Sprites/Actors/ChirrsmasGolem/jump_peak.png"), 1, false, false, 32, 34)
gm.sprite_replace(gm.constants.sGolemFall, path.combine(PATH, "Sprites/Actors/ChirrsmasGolem/fall.png"), 1, false, false, 32, 34)
gm.sprite_replace(gm.constants.sGolemPal, path.combine(PATH, "Sprites/Actors/ChirrsmasGolem/palette.png"), 1, false, false, 0, 0)
gm.sprite_replace(gm.constants.sCreditsMonsterGolem, path.combine(PATH, "Sprites/Actors/ChirrsmasGolem/credits.png"), 1, false, false, 20, 68)
gm.sprite_replace(gm.constants.sPing_Golem, path.combine(PATH, "Sprites/Actors/ChirrsmasGolem/ping.png"), 1, false, false, 32, 32)

gm.sprite_replace(gm.constants.sGolemS2Idle, path.combine(PATH, "Sprites/Actors/ChirrsmasGolem/idle.png"), 36, false, false, 26, 35)
gm.sprite_replace(gm.constants.sGolemS2Walk, path.combine(PATH, "Sprites/Actors/ChirrsmasGolem/walk.png"), 8, false, false, 27, 33)
gm.sprite_replace(gm.constants.sGolemS2Shoot1, path.combine(PATH, "Sprites/Actors/ChirrsmasGolem/attack.png"), 13, false, false, 55, 54)
gm.sprite_replace(gm.constants.sGolemS2Spawn, path.combine(PATH, "Sprites/Actors/ChirrsmasGolem/spawn.png"), 19, false, false, 43, 99)
gm.sprite_replace(gm.constants.sGolemS2Death, path.combine(PATH, "Sprites/Actors/ChirrsmasGolem/death.png"), 16, false, false, 60, 51)
gm.sprite_replace(gm.constants.sGolemS2Jump, path.combine(PATH, "Sprites/Actors/ChirrsmasGolem/jump.png"), 1, false, false, 32, 34)
gm.sprite_replace(gm.constants.sGolemS2JumpPeak, path.combine(PATH, "Sprites/Actors/ChirrsmasGolem/jump_peak.png"), 1, false, false, 32, 34)
gm.sprite_replace(gm.constants.sGolemS2Fall, path.combine(PATH, "Sprites/Actors/ChirrsmasGolem/fall.png"), 1, false, false, 32, 34)
gm.sprite_replace(gm.constants.sGolemS2Pal, path.combine(PATH, "Sprites/Actors/ChirrsmasGolem/palette.png"), 1, false, false, 0, 0)
gm.sprite_replace(gm.constants.sPing_GolemS2, path.combine(PATH, "Sprites/Actors/ChirrsmasGolem/ping.png"), 1, false, false, 32, 32)

gm.sprite_replace(gm.constants.sGolemSIdle, path.combine(PATH, "Sprites/Actors/ChirrsmasGolem/idle.png"), 36, false, false, 26, 35)
gm.sprite_replace(gm.constants.sGolemSWalk, path.combine(PATH, "Sprites/Actors/ChirrsmasGolem/walk.png"), 8, false, false, 27, 33)
gm.sprite_replace(gm.constants.sGolemSShoot1, path.combine(PATH, "Sprites/Actors/ChirrsmasGolem/attack.png"), 13, false, false, 55, 54)
gm.sprite_replace(gm.constants.sGolemSSpawn, path.combine(PATH, "Sprites/Actors/ChirrsmasGolem/spawn.png"), 19, false, false, 43, 99)
gm.sprite_replace(gm.constants.sGolemSDeath, path.combine(PATH, "Sprites/Actors/ChirrsmasGolem/death.png"), 16, false, false, 60, 51)
gm.sprite_replace(gm.constants.sGolemSPal, path.combine(PATH, "Sprites/Actors/ChirrsmasGolem/palette.png"), 1, false, false, 0, 0)
gm.sprite_replace(gm.constants.sCreditsMonsterGolemS, path.combine(PATH, "Sprites/Actors/ChirrsmasGolem/credits.png"), 1, false, false, 20, 68)
gm.sprite_replace(gm.constants.sPing_GolemS, path.combine(PATH, "Sprites/Actors/ChirrsmasGolem/ping.png"), 1, false, false, 32, 32)

gm.sprite_replace(gm.constants.sTitleDoodadsGolemIdle, path.combine(PATH, "Sprites/Actors/ChirrsmasGolem/doodad.png"), 1, false, false, 27, 63)