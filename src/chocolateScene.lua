require "gameCommon"

function overChocolateCallback()
    chocolateScene:cleanup()
    chocolateScene:addChild(createLayerGameOver(cc.Sprite:create("Images/Chocolate/chocolate_over.png")))
end
function winChocolateCallback()
    chocolateScene:cleanup()
    chocolateScene:addChild(createLayerGameWin("Chocolate"))
end
function addChocolateBee()
    missedBees = missedBees +1
    --bee:removeFromParent(true)
    local stateAction = {
        [1] = function() reference_bee1:setColor(cc.c3b(230, 25, 25));end,
        [2] = function() reference_bee2:setColor(cc.c3b(230, 25, 25));end,
        [3] = function() reference_bee3:setColor(cc.c3b(230, 25, 25));overChocolateCallback();end,
        [4] = function() end,
        [5] = function() end
    }
    stateAction[missedBees]()
end


function nextBeeFall()
    beeCount=beeCount+1
    bee[beeCount]:setPosition(visibleSize.width*.1+visibleSize.width*.01*math.random(100), visibleSize.height)

    bee[beeCount]:runAction(cc.Sequence:create(cc.MoveTo:create(1.5,cc.p(visibleSize.width*.5,visibleSize.height*.14)), cc.CallFunc:create(addChocolateBee)))     

end

function startChocolate()
    beeCount=0
    missedBees = 0
    startClock(20)
    chocolateScene:runAction(cc.Repeat:create(cc.Sequence:create(cc.DelayTime:create(.6), cc.CallFunc:create(nextBeeFall)),40))
    chocolateScene:runAction(cc.Sequence:create(cc.DelayTime:create(20), cc.CallFunc:create(winChocolateCallback)))
end

function chocolateView()
    chocolateScene = cc.Scene:createWithExit()
    layerLeft = createLayerLeft(startChocolate)
    chocolateScene:addChild(layerLeft)
    layerGame = createLayerChocolateGame()
    chocolateScene:addChild(layerGame)
    local info_wood = cc.Sprite:create("Images/Chocolate/info_wood.png")
    chocolateScene:addChild(createLayerInfoWood(info_wood, startChocolate))
    chocolateScene:addChild(createLayerClock())

    cc.SimpleAudioEngine:getInstance():stopMusic(true)
    cc.SimpleAudioEngine:getInstance():playMusic("Sounds/Music/Game1.mp3", true)
    return chocolateScene
end


function createLayerChocolateGame()
    layerScreen = cc.Layer:create()

    function layerScreen.restartGame (first)
        if not first then
            layerScreen:removeAllChildren()
            reference_bee1:removeFromParent()
            reference_bee2:removeFromParent()
            reference_bee3:removeFromParent()
        end

        layerSky = cc.LayerColor:create(cc.c4b(107,167,219,255), visibleSize.width*.85, visibleSize.height)
        layerSky:setPosition(visibleSize.width*.15, 0)
        layerScreen:addChild(layerSky)
    
        local layerGround = cc.LayerColor:create(cc.c4b(162,192,57,255), visibleSize.width*.85, visibleSize.height*.075)
        layerGround:setPosition(visibleSize.width*.15, 0)
        layerScreen:addChild(layerGround)

    
        local chocolate = cc.Sprite:create("Images/Chocolate/chocolate.png")
        chocolate:setPosition(visibleSize.width* 0.55, chocolate:getContentSize().height* 0.55)
        layerScreen:addChild(chocolate,100)
    
        gameToken = cc.Sprite:create("Images/Chocolate/chocolate_icon.png")
        gameToken:setPosition(visibleSize.width*0.5, visibleSize.height * 0.5)
        layerScreen:addChild(gameToken)
        gameToken:setVisible(false)
    
    
        reference_bee1 = cc.Sprite:create("Images/Chocolate/reference_bee.png")
        reference_bee1:setPosition(layerLeft:getContentSize().width*.5, visibleSize.height*.9)
        layerLeft:addChild(reference_bee1)
        reference_bee1:setColor(cc.c3b(215, 190, 91))
        reference_bee1:setScale(.8)
    
        reference_bee2 = cc.Sprite:create("Images/Chocolate/reference_bee.png")
        reference_bee2:setPosition(layerLeft:getContentSize().width*.5, visibleSize.height*.78)
        layerLeft:addChild(reference_bee2)
        reference_bee2:setColor(cc.c3b(215, 190, 91))
        reference_bee2:setScale(.8)
    
        reference_bee3 = cc.Sprite:create("Images/Chocolate/reference_bee.png")
        reference_bee3:setPosition(layerLeft:getContentSize().width*.5, visibleSize.height*.66)
        layerLeft:addChild(reference_bee3)
        reference_bee3:setColor(cc.c3b(215, 190, 91))
        reference_bee3:setScale(.8)

        bee_tex1 = cc.Sprite:create("Images/Chocolate/bee_1.png"):getTexture()
        bee_tex2 = cc.Sprite:create("Images/Chocolate/bee_2.png"):getTexture()

        bee = {}
        for i=1,40 do
            bee[i] = cc.Sprite:create("Images/Chocolate/bee_1.png")
            bee[i]:setPosition(0, visibleSize.height*1.1)
            layerScreen:addChild(bee[i])
            local flyFrame1=0
            local function beeFlyCallback()
                if flyFrame1%2 == 0 then
                    bee[i]:setTexture(bee_tex1)
                    else
                        bee[i]:setTexture(bee_tex2)
                end
                flyFrame1=flyFrame1+1
            end
            bee[i]:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(.1), cc.CallFunc:create(beeFlyCallback) )))

                -- handing touch events
            local function onTouchBegan(touch, event)
                local location = touch:getLocation()
                local rect = bee[i]:getBoundingBox()
                if cc.rectContainsPoint(rect, location) then
                    cc.SimpleAudioEngine:getInstance():playEffect("Sounds/Effects/chocolate/bee_click.mp3")
                    bee[i]:cleanup()
                    bee[i]:runAction(cc.Sequence:create(cc.MoveBy:create(.4, cc.p(visibleSize.width, 0))))
                end
    
                -- CCTOUCHBEGAN event must return true
                return true
            end
        
            local listener = cc.EventListenerTouchOneByOne:create()
            listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
            local eventDispatcher = bee[i]:getEventDispatcher()
            eventDispatcher:addEventListenerWithSceneGraphPriority(listener, bee[i])
        end
    end
    layerScreen.restartGame(true)
    return layerScreen
end
