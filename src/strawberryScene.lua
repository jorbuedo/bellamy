require "gameCommon"

function overStrawberryCallback()
    strawberryScene:cleanup()
    strawberryScene:addChild(createLayerGameOver(cc.Sprite:create("Images/Strawberry/strawberry_over.png")))
end
function winStrawberryCallback()
    strawberryScene:cleanup()
    strawberryScene:addChild(createLayerGameWin("Strawberry"))
end

function eatStrawberryCallback()
    strawberry:removeFromParent(true)
    strawberry=nil
    --nextStrawberry:setVisible(false)
end
function nextStrawberryFall()

    if math.random(100) < 20 then
        strawberry = cc.Sprite:create("Images/Strawberry/bad_strawberry.png")
        strawberry:setPosition(visibleSize.width * 0.2 + visibleSize.width * 0.01 * math.random(75), visibleSize.height * 0.1 + visibleSize.height * 0.01 * math.random(35))
        layerScreen:addChild(strawberry)
        strawberryIsBad = true
    else
        strawberry = cc.Sprite:create("Images/Strawberry/strawberry.png")
        strawberry:setPosition(visibleSize.width * 0.2 + visibleSize.width * 0.01 * math.random(75), visibleSize.height * 0.1 + visibleSize.height * 0.01 * math.random(35))
        layerScreen:addChild(strawberry)
        strawberryIsBad = false
    end

    strawberry:setRotation(-40)
    strawberry:setScale(.2)
    strawberry:runAction(cc.Sequence:create(cc.RotateBy:create(.3, math.random(100)), cc.DelayTime:create(.3), cc.RotateBy:create(.3, -math.random(100))))
    strawberry:runAction(cc.Sequence:create(cc.FadeIn:create(.3), cc.DelayTime:create(.3), cc.FadeOut:create(.3)))
    strawberry:runAction(cc.Sequence:create(cc.ScaleTo:create(.3, .9), cc.DelayTime:create(.3), cc.ScaleTo:create(.3, .1), cc.CallFunc:create(eatStrawberryCallback)))     

end
function startStrawberry()
    strawberryPoints = moveToken(0)
    strawberryScene:cleanup()
    startClock(30)
    strawberryScene:runAction(cc.Repeat:create(cc.Sequence:create(cc.CallFunc:create(nextStrawberryFall),cc.DelayTime:create(1)),30))
    strawberryScene:runAction(cc.Sequence:create(cc.DelayTime:create(30), cc.CallFunc:create(overStrawberryCallback)))
end


function strawberryView()
    strawberryScene = cc.Scene:createWithExit()
    layerLeft = createLayerLeft(startStrawberry,"Images/Strawberry/strawberry.png")
    strawberryScene:addChild(layerLeft)
    layerGame = createLayerStrawberryGame()
    strawberryScene:addChild(layerGame)
    local info_wood = cc.Sprite:create("Images/Strawberry/info_wood.png")
    strawberryScene:addChild(createLayerInfoWood(info_wood, startStrawberry))
    strawberryScene:addChild(createLayerClock())

    cc.SimpleAudioEngine:getInstance():stopMusic(true)
    cc.SimpleAudioEngine:getInstance():playMusic("Sounds/Music/Game1.mp3", true)
    return strawberryScene
end


function createLayerStrawberryGame()
    layerScreen = cc.Layer:create()


    function layerScreen.restartGame (first)
        if not first then
            layerScreen:removeAllChildren()
        end

        layerSky = cc.LayerColor:create(cc.c4b(107,167,219,255), visibleSize.width*.85, visibleSize.height)
        layerSky:setPosition(visibleSize.width*.15, 0)
        layerScreen:addChild(layerSky)
        local strawberry_tree = cc.Sprite:create("Images/Strawberry/strawberry_tree.png")
        strawberry_tree:setPosition(visibleSize.width * 0.575, strawberry_tree:getContentSize().height * 0.5)
        layerScreen:addChild(strawberry_tree)
        strawberry_tree:setScale(1.005) 
    end
    layerScreen.restartGame(true)

                -- handing touch events
    local function onTouchBegan(touch, event)
        local location = touch:getLocation()
        if strawberry and cc.rectContainsPoint(strawberry:getBoundingBox(), location) then    
            cc.SimpleAudioEngine:getInstance():playEffect("Sounds/Effects/strawberry/strawberry_click.mp3")
            strawberry:cleanup()
            eatStrawberryCallback()
            if strawberryIsBad then
                strawberryPoints = strawberryPoints - 20
            else
                strawberryPoints = strawberryPoints + 10
            end
            
            if moveToken(strawberryPoints) == 100 then
                strawberryScene:runAction(cc.Sequence:create(cc.DelayTime:create(.3), cc.CallFunc:create(winStrawberryCallback)))
            end
        end
        -- CCTOUCHBEGAN event must return true
        return true
    end
    local function onTouchMoved(touch, event)
        local location = touch:getLocation()

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
