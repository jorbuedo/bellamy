function createLayerTable(endGame)
    local layerTable = cc.Layer:create()
    local table = cc.Sprite:create("Images/Table/table.png")
    table:setTag(213)
    layerTable:setPosition(0, visibleSize.height-table:getContentSize().height*.45)

    table:setPosition(visibleSize.width*.5, visibleSize.height)
    layerTable:addChild(table)

    local stamp_apple_star = cc.Sprite:create("Images/Table/stamp_apple_star.png")
    stamp_apple_star:setPosition(table:getContentSize().width*.765, table:getContentSize().height*.265)
    table:addChild(stamp_apple_star)
    stamp_apple_star:setScale(.35)
    stamp_apple_star:setVisible(stamp_apple_star_won)

    local stamp_chocolate_star = cc.Sprite:create("Images/Table/stamp_chocolate_star.png")
    stamp_chocolate_star:setPosition(table:getContentSize().width*.265, table:getContentSize().height*.57)
    table:addChild(stamp_chocolate_star)
    stamp_chocolate_star:setScale(.35)
    stamp_chocolate_star:setVisible(stamp_chocolate_star_won)


    local stamp_egg_star = cc.Sprite:create("Images/Table/stamp_egg_star.png")
    stamp_egg_star:setPosition(table:getContentSize().width*.265, table:getContentSize().height*.265)
    table:addChild(stamp_egg_star)
    stamp_egg_star:setScale(.35)
    stamp_egg_star:setVisible(stamp_egg_star_won)

    local stamp_milk_star = cc.Sprite:create("Images/Table/stamp_milk_star.png")
    stamp_milk_star:setPosition(table:getContentSize().width*.52, table:getContentSize().height*.265)
    table:addChild(stamp_milk_star)
    stamp_milk_star:setScale(.35)
    stamp_milk_star:setVisible(stamp_milk_star_won)

    local stamp_strawberry_star = cc.Sprite:create("Images/Table/stamp_strawberry_star.png")
    stamp_strawberry_star:setPosition(table:getContentSize().width*.765, table:getContentSize().height*.57)
    table:addChild(stamp_strawberry_star)
    stamp_strawberry_star:setScale(.35)
    stamp_strawberry_star:setVisible(stamp_strawberry_star_won)

    local stamp_wheat_star = cc.Sprite:create("Images/Table/stamp_wheat_star.png")
    stamp_wheat_star:setPosition(table:getContentSize().width*.52, table:getContentSize().height*.57)
    table:addChild(stamp_wheat_star)
    stamp_wheat_star:setScale(.35)
    stamp_wheat_star:setVisible(stamp_wheat_star_won)


    layerTable:runAction(cc.Sequence:create(cc.MoveBy:create(.8, cc.p(0, -visibleSize.height*1.05)),cc.MoveBy:create(.2, cc.p(0, visibleSize.height*0.05))))
    cc.SimpleAudioEngine:getInstance():playEffect("Sounds/Effects/info_down.mp3")
 
    local function deleteCallback()
        layerTable:removeFromParent(true)
    end
        -- handing touch events
    local function onTouchBegan(touch, event)
        if not endGame then
            cc.SimpleAudioEngine:getInstance():playEffect("Sounds/Effects/info_up.mp3")
            layerTable:runAction(cc.Sequence:create(cc.MoveBy:create(.2, cc.p(0,-visibleSize.height*.05)), cc.MoveBy:create(.8, cc.p(0,visibleSize.height*1.05)), cc.CallFunc:create(deleteCallback)))
        end

        -- CCTOUCHBEGAN event must return true
        return true
    end
    local function onTouchMoved(touch, event)

    end
    local function onTouchEnded(touch, event)
        
    end

    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
    listener:registerScriptHandler(onTouchMoved,cc.Handler.EVENT_TOUCH_MOVED )
    listener:registerScriptHandler(onTouchEnded,cc.Handler.EVENT_TOUCH_ENDED )
    listener:setSwallowTouches(true)

    local eventDispatcher = layerTable:getEventDispatcher()

    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, layerTable)


    return layerTable
end