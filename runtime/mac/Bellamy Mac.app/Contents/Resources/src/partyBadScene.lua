
function partyBadView(cake)
    local partyBadScene = cc.Scene:createWithExit()
    partyBadScene:addChild(createLayerBlueSky())
    partyBadScene:addChild(createLayerClouds())
    partyBadScene:addChild(createLayerPartyBad(cake))

    cc.SimpleAudioEngine:getInstance():stopMusic(true)
    cc.SimpleAudioEngine:getInstance():playMusic("Sounds/Music/Final_bad.mp3", true)
    return partyBadScene
end
function createLayerBlueSky()
    local blueSky = cc.c4b(107,167,219,255)
    local layerBGColor = cc.LayerColor:create(blueSky)
    return layerBGColor
end
function createLayerClouds()
    local layerClouds = cc.Layer:create()

    -- add in farm background
    local clouds = cc.Sprite:create("Images/Init/clouds.png")
    clouds:setPosition(visibleSize.width * 0.5, visibleSize.height * 0.5)
    layerClouds:addChild(clouds)

    local clouds2 = cc.Sprite:create("Images/Init/clouds.png")
    clouds2:setPosition(visibleSize.width + visibleSize.width * 0.5, visibleSize.height * 0.5)
    clouds:addChild(clouds2)

    clouds:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.MoveBy:create(60, cc.p(-1*visibleSize.width,0)), cc.MoveBy:create(0, cc.p(visibleSize.width,0)))))

    return layerClouds
end
function createLayerPartyBad(cake)
    local layerPartyBad = cc.Layer:create()


    local final_back = cc.Sprite:create("Images/Party/bad/final_back.png")
    final_back:setPosition(visibleSize.width * 0.5, visibleSize.height * 0.5)
    layerPartyBad:addChild(final_back)

    local final_back_flag = cc.Sprite:create("Images/Party/bad/final_back_flag.png")
    final_back_flag:setPosition(visibleSize.width * 0.5, visibleSize.height * 0.5)
    layerPartyBad:addChild(final_back_flag)

    local cat = cc.Sprite:create("Images/Party/bad/cat.png")
    cat:setPosition(visibleSize.width * 0.85, visibleSize.height * 0.7)
    layerPartyBad:addChild(cat)

    local dog = cc.Sprite:create("Images/Party/bad/dog.png")
    dog:setPosition(visibleSize.width * 0.96, visibleSize.height * 0.55)
    layerPartyBad:addChild(dog)

    local kid = cc.Sprite:create("Images/Party/bad/kid.png")
    kid:setPosition(visibleSize.width * 0.68, visibleSize.height * 0.53)
    layerPartyBad:addChild(kid)

    local girl = cc.Sprite:create("Images/Party/bad/girl.png")
    girl:setPosition(visibleSize.width * 0.33, visibleSize.height * 0.53)
    layerPartyBad:addChild(girl)

    local table = cc.Sprite:create("Images/Party/bad/table.png")
    table:setPosition(visibleSize.width * 0.5, visibleSize.height * 0.25)
    layerPartyBad:addChild(table)

    layerPartyBad:addChild(cake)
    cake:setPosition(visibleSize.width * 0.5, visibleSize.height * 0.35)
    cake:setAnchorPoint(.5,0)
    cake:setScale(.4)
    cake:setVisible(true)


    local boy = cc.Sprite:create("Images/Party/bad/boy.png")
    boy:setPosition(visibleSize.width * 0.18, visibleSize.height * 0.47)
    layerPartyBad:addChild(boy)


    local chicken_1 = cc.Sprite:create("Images/Party/bad/chicken_1.png")
    chicken_1:setPosition(visibleSize.width * 0.665, visibleSize.height * 0.15)
    layerPartyBad:addChild(chicken_1)

    local chicken_2 = cc.Sprite:create("Images/Party/bad/chicken_2.png")
    chicken_2:setPosition(visibleSize.width * 0.74, visibleSize.height * 0.1)
    layerPartyBad:addChild(chicken_2)

    local cow = cc.Sprite:create("Images/Party/bad/cow.png")
    cow:setPosition(visibleSize.width * 0.88, visibleSize.height * 0.25)
    layerPartyBad:addChild(cow)


    local sheep = cc.Sprite:create("Images/Party/bad/sheep.png")
    sheep:setPosition(visibleSize.width * 0.15, visibleSize.height * 0.25)
    layerPartyBad:addChild(sheep)

    local pig = cc.Sprite:create("Images/Party/bad/pig.png")
    pig:setPosition(visibleSize.width * 0.28, visibleSize.height * 0.15)
    layerPartyBad:addChild(pig)

    stamp_apple_star_won = cc.UserDefault:getInstance():setBoolForKey("stamp_apple_star_won", false)
    stamp_chocolate_star_won = cc.UserDefault:getInstance():setBoolForKey("stamp_chocolate_star_won", false)
    stamp_egg_star_won = cc.UserDefault:getInstance():setBoolForKey("stamp_egg_star_won", false)
    stamp_milk_star_won = cc.UserDefault:getInstance():setBoolForKey("stamp_milk_star_won", false)
    stamp_strawberry_star_won = cc.UserDefault:getInstance():setBoolForKey("stamp_strawberry_star_won", false)
    stamp_wheat_star_won = cc.UserDefault:getInstance():setBoolForKey("stamp_wheat_star_won", false)
    stamp_apple_star_won = nil
    stamp_chocolate_star_won = nil
    stamp_egg_star_won = nil
    stamp_milk_star_won = nil
    stamp_strawberry_star_won = nil
    stamp_wheat_star_won = nil
        -- handing touch events
    local function onTouchBegan(touch, event)
        local location = touch:getLocation()

        -- CCTOUCHBEGAN event must return true
        return true
    end
    local function onTouchMoved(touch, event)
        local location = touch:getLocation()

    end
    local function onTouchEnded(touch, event)

        cc.Director:getInstance():replaceScene( cc.TransitionFade:create(1, menuView(), cc.c3b(0,0,0))  )
    end

    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
    listener:registerScriptHandler(onTouchMoved,cc.Handler.EVENT_TOUCH_MOVED )
    listener:registerScriptHandler(onTouchEnded,cc.Handler.EVENT_TOUCH_ENDED )
    local eventDispatcher = layerPartyBad:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, layerPartyBad)


    return layerPartyBad
end
