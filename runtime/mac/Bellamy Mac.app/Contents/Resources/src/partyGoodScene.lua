
function partyGoodView(cake)
    local partyGoodScene = cc.Scene:createWithExit()
    partyGoodScene:addChild(createLayerBlueSky())
    partyGoodScene:addChild(createLayerClouds())
    partyGoodScene:addChild(createLayerPartyGood(cake))

--    cc.SimpleAudioEngine:getInstance():stopMusic(true)
--    cc.SimpleAudioEngine:getInstance():playMusic("Sounds/Music/Final.mp3", true)
    return partyGoodScene
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
function createLayerPartyGood(cake)
    local layerPartyGood = cc.Layer:create()


    local final_back = cc.Sprite:create("Images/Party/good/final_back.png")
    final_back:setPosition(visibleSize.width * 0.5, visibleSize.height * 0.5)
    layerPartyGood:addChild(final_back)

    local final_back_flag = cc.Sprite:create("Images/Party/good/final_back_flag.png")
    final_back_flag:setPosition(visibleSize.width * 0.5, visibleSize.height * 0.5)
    layerPartyGood:addChild(final_back_flag)

    local happy_cat = cc.Sprite:create("Images/Party/good/happy_cat.png")
    happy_cat:setPosition(visibleSize.width * 0.85, visibleSize.height * 0.7)
    layerPartyGood:addChild(happy_cat)

    local happy_dog = cc.Sprite:create("Images/Party/good/happy_dog.png")
    happy_dog:setPosition(visibleSize.width * 0.96, visibleSize.height * 0.55)
    layerPartyGood:addChild(happy_dog)

    local kid = cc.Sprite:create("Images/Party/good/kid.png")
    kid:setPosition(visibleSize.width * 0.68, visibleSize.height * 0.53)
    layerPartyGood:addChild(kid)

    local happy_girl = cc.Sprite:create("Images/Party/good/happy_girl.png")
    happy_girl:setPosition(visibleSize.width * 0.33, visibleSize.height * 0.53)
    layerPartyGood:addChild(happy_girl)

    local table = cc.Sprite:create("Images/Party/good/table.png")
    table:setPosition(visibleSize.width * 0.5, visibleSize.height * 0.25)
    layerPartyGood:addChild(table)

    layerPartyGood:addChild(cake)
    cake:setPosition(visibleSize.width * 0.5, visibleSize.height * 0.35)
    cake:setAnchorPoint(.5,0)
    cake:setScale(.4)


    local happy_boy = cc.Sprite:create("Images/Party/good/happy_boy.png")
    happy_boy:setPosition(visibleSize.width * 0.18, visibleSize.height * 0.47)
    layerPartyGood:addChild(happy_boy)


    local happy_chicken_1 = cc.Sprite:create("Images/Party/good/happy_chicken_1.png")
    happy_chicken_1:setPosition(visibleSize.width * 0.665, visibleSize.height * 0.15)
    layerPartyGood:addChild(happy_chicken_1)

    local happy_chicken_2 = cc.Sprite:create("Images/Party/good/happy_chicken_2.png")
    happy_chicken_2:setPosition(visibleSize.width * 0.74, visibleSize.height * 0.1)
    layerPartyGood:addChild(happy_chicken_2)

    local happy_cow = cc.Sprite:create("Images/Party/good/happy_cow.png")
    happy_cow:setPosition(visibleSize.width * 0.88, visibleSize.height * 0.25)
    layerPartyGood:addChild(happy_cow)


    local happy_sheep = cc.Sprite:create("Images/Party/good/happy_sheep.png")
    happy_sheep:setPosition(visibleSize.width * 0.15, visibleSize.height * 0.25)
    layerPartyGood:addChild(happy_sheep)

    local happy_pig = cc.Sprite:create("Images/Party/good/happy_pig.png")
    happy_pig:setPosition(visibleSize.width * 0.28, visibleSize.height * 0.15)
    layerPartyGood:addChild(happy_pig)

    cake:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(math.random(10)*.1), cc.MoveBy:create(.3, cc.p(0,visibleSize.height*.05)), cc.MoveBy:create(.3, cc.p(0, visibleSize.height*-.05)))))
    kid:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(math.random(10)*.1), cc.MoveBy:create(.3, cc.p(0,visibleSize.height*.05)), cc.MoveBy:create(.3, cc.p(0, visibleSize.height*-.05)))))
    happy_cat:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(math.random(10)*.1), cc.MoveBy:create(.3, cc.p(0,visibleSize.height*.05)), cc.MoveBy:create(.3, cc.p(0, visibleSize.height*-.05)))))
    happy_dog:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(math.random(10)*.1), cc.MoveBy:create(.3, cc.p(0,visibleSize.height*.05)), cc.MoveBy:create(.3, cc.p(0, visibleSize.height*-.05)))))
    happy_girl:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(math.random(10)*.1), cc.MoveBy:create(.3, cc.p(0,visibleSize.height*.05)), cc.MoveBy:create(.3, cc.p(0, visibleSize.height*-.05)))))
    happy_boy:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(math.random(10)*.1), cc.MoveBy:create(.3, cc.p(0,visibleSize.height*.05)), cc.MoveBy:create(.3, cc.p(0, visibleSize.height*-.05)))))
    happy_chicken_1:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(math.random(10)*.1), cc.MoveBy:create(.3, cc.p(0,visibleSize.height*.05)), cc.MoveBy:create(.3, cc.p(0, visibleSize.height*-.05)))))
    happy_chicken_2:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(math.random(10)*.1), cc.MoveBy:create(.3, cc.p(0,visibleSize.height*.05)), cc.MoveBy:create(.3, cc.p(0, visibleSize.height*-.05)))))
    happy_cow:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(math.random(10)*.1), cc.MoveBy:create(.3, cc.p(0,visibleSize.height*.05)), cc.MoveBy:create(.3, cc.p(0, visibleSize.height*-.05)))))
    happy_sheep:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(math.random(10)*.1), cc.MoveBy:create(.3, cc.p(0,visibleSize.height*.05)), cc.MoveBy:create(.3, cc.p(0, visibleSize.height*-.05)))))
    happy_pig:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(math.random(10)*.1), cc.MoveBy:create(.3, cc.p(0,visibleSize.height*.05)), cc.MoveBy:create(.3, cc.p(0, visibleSize.height*-.05)))))


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

        cc.Director:getInstance():replaceScene(cc.TransitionFade:create(1, menuView(), cc.c3b(0,0,0)) )
    end

    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
    listener:registerScriptHandler(onTouchMoved,cc.Handler.EVENT_TOUCH_MOVED )
    listener:registerScriptHandler(onTouchEnded,cc.Handler.EVENT_TOUCH_ENDED )
    local eventDispatcher = layerPartyGood:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, layerPartyGood)


    return layerPartyGood
end
