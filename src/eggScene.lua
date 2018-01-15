require "gameCommon"

function overEggCallback()
    eggScene:cleanup()
    eggScene:addChild(createLayerGameOver(cc.Sprite:create("Images/Egg/egg_over.png")))
end
function winEggCallback()
    eggScene:cleanup()
    eggScene:addChild(createLayerGameWin("Egg"))
end

function eatEggCallback()
    prev,eggFinished = next(eggList,prev)
    local location = cc.p(eggFinished.locX, 0)
    local rect  = basket:getBoundingBox()
    if cc.rectContainsPoint(rect, location) then
        cc.SimpleAudioEngine:getInstance():playEffect("Sounds/Effects/egg/chicken_touch.mp3") 
        if eggFinished.isBad then
            eggPoints=moveToken(eggPoints-10)
        else 
            eggPoints=moveToken(eggPoints+5)
            if eggPoints==100 then
                eggScene:runAction(cc.Sequence:create(cc.DelayTime:create(.3), cc.CallFunc:create(winEggCallback)))
            end
        end
    end
end

function nextEggFall()
    luckyChickenNum = math.random(4)
    if math.random(100) < 40 then
        egg = cc.Sprite:create("Images/Egg/bad_egg.png")
        egg:setPosition(visibleSize.width*.085+ visibleSize.width * 0.2 * luckyChickenNum, chicken_holder:getPositionY()+egg:getContentSize().height*.05)
        layerScreen:addChild(egg)
        eggIsBad = true
    else
        egg = cc.Sprite:create("Images/Egg/egg.png")
        egg:setPosition(visibleSize.width*.085+ visibleSize.width * 0.2 * luckyChickenNum, chicken_holder:getPositionY()+egg:getContentSize().height*.05)
        layerScreen:addChild(egg)
        eggIsBad = false
    end

    chicken = layerScreen:getChildByTag(200+luckyChickenNum)

    egg:setScale(.8)
    eggCount=eggCount+1
    eggList[eggCount] = {}
    eggList[eggCount].locX=egg:getPositionX()
    eggList[eggCount].isBad=eggIsBad

    chicken:runAction(cc.Sequence:create(cc.ScaleTo:create(.2,1,.7),cc.ScaleTo:create(.2, 1,1)))

    egg:runAction(cc.Sequence:create(cc.DelayTime:create(.1),cc.MoveBy:create(1, cc.p(0, -visibleSize.height * 0.8)), cc.CallFunc:create(eatEggCallback)))
end

function startEgg()
    prev=nil
    eggCount=0
    eggList = {}
    eggPoints = moveToken(0)
    eggScene:cleanup()
    startClock(30)
    eggScene:runAction(cc.Sequence:create(cc.DelayTime:create(30), cc.CallFunc:create(overEggCallback)))
    eggScene:runAction(cc.Repeat:create(cc.Sequence:create(cc.DelayTime:create(.5), cc.CallFunc:create(nextEggFall)),100))
end

function eggView()
    eggScene = cc.Scene:createWithExit()
    layerLeft = createLayerLeft(startEgg,"Images/Egg/egg.png")
    eggScene:addChild(layerLeft)
    layerGame = createLayerEggGame()
    eggScene:addChild(layerGame)
    local info_wood = cc.Sprite:create("Images/Egg/info_wood.png")
    eggScene:addChild(createLayerInfoWood(info_wood, startEgg))
    eggScene:addChild(createLayerClock())

    cc.SimpleAudioEngine:getInstance():stopMusic(true)
    cc.SimpleAudioEngine:getInstance():playMusic("Sounds/Music/Game2.mp3", true)
    return eggScene
end


function createLayerEggGame()
    layerScreen = cc.Layer:create()
    
    function layerScreen.restartGame (first)
        if not first then
            layerScreen:removeAllChildren()
        end

        layerSky = cc.LayerColor:create(cc.c4b(107,167,219,255), visibleSize.width*.85, visibleSize.height)
        layerSky:setPosition(visibleSize.width*.15, 0)
        layerScreen:addChild(layerSky)
    
        basket = cc.Sprite:create("Images/Egg/basket.png")
        basket:setPosition(visibleSize.width * 0.5, basket:getContentSize().height*.15)
        layerScreen:addChild(basket,1000)

        chicken_holder = cc.Sprite:create("Images/Egg/chicken_holder.png")
        chicken_holder:setPosition(visibleSize.width * 0.577, visibleSize.height * 0.7)
        layerScreen:addChild(chicken_holder,1005)
        chicken_holder:setScale(1.01)

        chicken_1 = cc.Sprite:create("Images/Egg/chicken_1.png")
        chicken_1:setPosition(visibleSize.width * 0.285, chicken_holder:getPositionY()+ chicken_1:getContentSize().height * 0.31)
        chicken_1:setTag(201)
        layerScreen:addChild(chicken_1,1001)
    
        chicken_2 = cc.Sprite:create("Images/Egg/chicken_2.png")
        chicken_2:setPosition(visibleSize.width * 0.485, chicken_holder:getPositionY()+ chicken_1:getContentSize().height * 0.31)
        chicken_2:setTag(202)
        layerScreen:addChild(chicken_2,1002)
    
        chicken_21 = cc.Sprite:create("Images/Egg/chicken_1.png")
        chicken_21:setPosition(visibleSize.width * 0.685, chicken_holder:getPositionY()+ chicken_1:getContentSize().height * 0.31)
        chicken_21:setTag(203)
        layerScreen:addChild(chicken_21,1003)
    
        chicken_22 = cc.Sprite:create("Images/Egg/chicken_2.png")
        chicken_22:setPosition(visibleSize.width * 0.89, chicken_holder:getPositionY()+ chicken_1:getContentSize().height * 0.31)
        chicken_22:setTag(204)
        layerScreen:addChild(chicken_22,1004)
    

    

    end
    layerScreen.restartGame(true)
        
            -- handing touch events
    local function onTouchBegan(touch, event)
        local location = touch:getLocationInView()
        local locX = location.x
        if locX < visibleSize.width*.25 then locX = visibleSize.width*.25 end
        if locX > visibleSize.width*.9 then locX = visibleSize.width*.9 end
        basket:runAction(cc.MoveTo:create(.2,cc.p(locX, basket:getContentSize().height*.15)))
        -- CCTOUCHBEGAN event must return true
        return true
    end
    local function onTouchMoved(touch, event)
        local location = touch:getLocationInView()
        local locX = location.x
        if locX < visibleSize.width*.25 then locX = visibleSize.width*.25 end
        if locX > visibleSize.width*.9 then locX = visibleSize.width*.9 end
        basket:setPosition(locX, basket:getContentSize().height*.15)
    end
    local function onTouchEnded(touch, event)
        local location = touch:getLocation()

    end

    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
    listener:registerScriptHandler(onTouchMoved,cc.Handler.EVENT_TOUCH_MOVED )
    listener:registerScriptHandler(onTouchEnded,cc.Handler.EVENT_TOUCH_ENDED )
    local eventDispatcher = layerScreen:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, layerScreen)
    return layerScreen
end
