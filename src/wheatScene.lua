require "gameCommon"

function distanceBetweenPointAndPoint(point1, point2)
    dx = point1.x - point2.x
    dy = point1.y - point2.y
    return math.sqrt(dx*dx + dy*dy)
end
function angleInDegreesBetweenLineFromPoint_toPoint_toLineFromPoint_toPoint(beginLineA, endLineA, beginLineB, endLineB)
    local a = endLineA.x - beginLineA.x
    local b = endLineA.y - beginLineA.y
    local c = endLineB.x - beginLineB.x
    local d = endLineB.y - beginLineB.y
    
    local atanA = math.atan2(a, b)
    local atanB = math.atan2(c, d)
    
    return (atanA - atanB) * 180 / math.pi
end

function overWheatCallback()
    wheatScene:cleanup()
    wheatScene:addChild(createLayerGameOver(cc.Sprite:create("Images/Wheat/wheat_over.png")))
end
function winWheatCallback()
    wheatScene:cleanup()
    wonYet=true
    wheatScene:addChild(createLayerGameWin("Wheat"))
end


function birdFlyCallback()
    if flyFrame1%3 == 0 then
        bird:setTexture(bird_tex3)
    elseif flyFrame1%2 == 0 then
        bird:setTexture(bird_tex2)
    else
        bird:setTexture(bird_tex1)
    end
    flyFrame1=flyFrame1+1
end
function eatWheatCallback()
    wheat[birdSelection]:removeFromParent(true)
    wheat[birdSelection]=nil
end
function birdTakesWheat()
    cc.SimpleAudioEngine:getInstance():playEffect("Sounds/Effects/wheat/wheat_touch.mp3")
    wheat[birdSelection]:runAction(cc.Sequence:create(cc.MoveBy:create(1, cc.p(0, visibleSize.height)), cc.CallFunc:create(eatWheatCallback)))
    wheatLayer[birdSelection]:removeFromParent(true)
end
function nextBirdFall()
    birdSelection = math.random(45)
    birdSelectedWheat = nil
    if wheat[birdSelection] then birdSelectedWheat = wheat[birdSelection] end

    while not birdSelectedWheat do

        if birdSelection == 45 then
            birdSelection = 1
        else
            birdSelection = birdSelection +1
        end
        if wheat[birdSelection] then birdSelectedWheat = wheat[birdSelection] end
    end

    bird:runAction(cc.Sequence:create(cc.MoveTo:create(0.3, cc.p(birdSelectedWheat:getPositionX(),birdSelectedWheat:getPositionY())), cc.CallFunc:create(birdTakesWheat), cc.MoveBy:create(1, cc.p(0, visibleSize.height)), cc.MoveTo:create(0, cc.p(visibleSize.width-visibleSize.width*math.random(100)*.01, visibleSize.height*1.1))))
end

function startWheat()
    wonYet=nil
    wheatScene:cleanup()
    wheatPoints=moveToken(0)
    startClock(20)
    wheatScene:runAction(cc.Repeat:create(cc.Sequence:create(cc.CallFunc:create(nextBirdFall),cc.DelayTime:create(1.7)),45))
    wheatScene:runAction(cc.Sequence:create(cc.DelayTime:create(20), cc.CallFunc:create(overWheatCallback)))
    bird:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(.1), cc.CallFunc:create(birdFlyCallback) )))
end

function wheatView()
    wheatScene = cc.Scene:createWithExit()
    layerLeft = createLayerLeft(startWheat, "Images/Wheat/wheat.png")
    wheatScene:addChild(layerLeft)
    layerGame = createLayerWheatGame()
    wheatScene:addChild(layerGame)
    local info_wood = cc.Sprite:create("Images/Wheat/info_wood.png")
    wheatScene:addChild(createLayerInfoWood(info_wood, startWheat))
    wheatScene:addChild(createLayerClock())

    cc.SimpleAudioEngine:getInstance():stopMusic(true)
    cc.SimpleAudioEngine:getInstance():playMusic("Sounds/Music/Game2.mp3", true)
    return wheatScene
end

function createLayerWheatGame()
    local layerScreen = cc.Layer:create()

    function layerScreen.restartGame (first)
        if not first then
            layerScreen:removeAllChildren()
        end

        local layerSky = cc.LayerColor:create(cc.c4b(107,167,219,255), visibleSize.width*.85, visibleSize.height)
        layerSky:setPosition(visibleSize.width*.15, 0)
        layerScreen:addChild(layerSky)
        local layerGround = cc.LayerColor:create(cc.c4b(162,192,57,255), visibleSize.width*.85, visibleSize.height*.75)
        layerGround:setPosition(visibleSize.width*.15, 0)
        layerScreen:addChild(layerGround)
    

        wheat = {}
        wheatLayer = {}
    
        for i=1,6 do
            wheat[i] = cc.Sprite:create("Images/Wheat/wheat.png")
            wheat[i]:setPosition(visibleSize.width*.18 + wheat[i]:getContentSize().width*i*1.15, layerGround:getContentSize().height*.81)
            layerScreen:addChild(wheat[i])
            wheat[i]:setAnchorPoint(.5,0)

            wheatLayer[i] = cc.LayerColor:create(cc.c4b(255,255,255,0), visibleSize.width*.05, visibleSize.height*.18)
            wheatLayer[i]:setPosition(visibleSize.width*.155 + wheat[i]:getContentSize().width*i*1.15, layerGround:getContentSize().height*.81)
            layerScreen:addChild(wheatLayer[i])
        end
    
        for i=1,7 do
            wheat[i+6] = cc.Sprite:create("Images/Wheat/wheat.png")
            wheat[i+6]:setPosition(visibleSize.width*.12 +wheat[i+6]:getContentSize().width*i*1.15, layerGround:getContentSize().height*.81 - 1/resolutionScaleY*wheat[i]:getContentSize().height*.45)
            layerScreen:addChild(wheat[i+6])
            wheat[i+6]:setAnchorPoint(.5,0)

            wheatLayer[i+6] = cc.LayerColor:create(cc.c4b(255,255,255,0), visibleSize.width*.05, visibleSize.height*.18)
            wheatLayer[i+6]:setPosition(visibleSize.width*.095 + wheat[i]:getContentSize().width*i*1.15, layerGround:getContentSize().height*.81- 1/resolutionScaleY*wheat[i]:getContentSize().height*.45)
            layerScreen:addChild(wheatLayer[i+6])
        end
    
        for i=1,6 do
            wheat[i+13] = cc.Sprite:create("Images/Wheat/wheat.png")
            wheat[i+13]:setPosition(visibleSize.width*.18 + wheat[i+13]:getContentSize().width*i*1.15, layerGround:getContentSize().height*.81 - 1/resolutionScaleY*wheat[i]:getContentSize().height*.9)
            layerScreen:addChild(wheat[i+13])
            wheat[i+13]:setAnchorPoint(.5,0)

            wheatLayer[i+13] = cc.LayerColor:create(cc.c4b(255,255,255,0), visibleSize.width*.05, visibleSize.height*.18)
            wheatLayer[i+13]:setPosition(visibleSize.width*.155 + wheat[i]:getContentSize().width*i*1.15, layerGround:getContentSize().height*.81- 1/resolutionScaleY*wheat[i]:getContentSize().height*.9)
            layerScreen:addChild(wheatLayer[i+13])
        end
    
        for i=1,7 do
            wheat[i+19] = cc.Sprite:create("Images/Wheat/wheat.png")
            wheat[i+19]:setPosition(visibleSize.width*.12 +wheat[i+19]:getContentSize().width*i*1.15, layerGround:getContentSize().height*.81 - 1/resolutionScaleY*wheat[i]:getContentSize().height*1.35)
            layerScreen:addChild(wheat[i+19])
            wheat[i+19]:setAnchorPoint(.5,0)

            wheatLayer[i+19] = cc.LayerColor:create(cc.c4b(255,255,255,0), visibleSize.width*.05, visibleSize.height*.18)
            wheatLayer[i+19]:setPosition(visibleSize.width*.095 + wheat[i]:getContentSize().width*i*1.15, layerGround:getContentSize().height*.81- 1/resolutionScaleY*wheat[i]:getContentSize().height*1.35)
            layerScreen:addChild(wheatLayer[i+19])
        end
    
        for i=1,6 do
            wheat[i+26] = cc.Sprite:create("Images/Wheat/wheat.png")
            wheat[i+26]:setPosition(visibleSize.width*.18 + wheat[i+26]:getContentSize().width*i*1.15, layerGround:getContentSize().height*.81 - 1/resolutionScaleY*wheat[i]:getContentSize().height*1.8)
            layerScreen:addChild(wheat[i+26])
            wheat[i+26]:setAnchorPoint(.5,0)

            wheatLayer[i+26] = cc.LayerColor:create(cc.c4b(255,255,255,0), visibleSize.width*.05, visibleSize.height*.18)
            wheatLayer[i+26]:setPosition(visibleSize.width*.155 + wheat[i]:getContentSize().width*i*1.15, layerGround:getContentSize().height*.81- 1/resolutionScaleY*wheat[i]:getContentSize().height*1.8)
            layerScreen:addChild(wheatLayer[i+26])
        end
    
        for i=1,7 do
            wheat[i+32] = cc.Sprite:create("Images/Wheat/wheat.png")
            wheat[i+32]:setPosition(visibleSize.width*.12 +wheat[i+32]:getContentSize().width*i*1.15, layerGround:getContentSize().height*.81 - 1/resolutionScaleY*wheat[i]:getContentSize().height*2.25)
            layerScreen:addChild(wheat[i+32])
            wheat[i+32]:setAnchorPoint(.5,0)

            wheatLayer[i+32] = cc.LayerColor:create(cc.c4b(255,255,255,0), visibleSize.width*.05, visibleSize.height*.18)
            wheatLayer[i+32]:setPosition(visibleSize.width*.095 + wheat[i]:getContentSize().width*i*1.15, layerGround:getContentSize().height*.81- 1/resolutionScaleY*wheat[i]:getContentSize().height*2.25)
            layerScreen:addChild(wheatLayer[i+32])
        end
    
        for i=1,6 do
            wheat[i+39] = cc.Sprite:create("Images/Wheat/wheat.png")
            wheat[i+39]:setPosition(visibleSize.width*.18 + wheat[i+39]:getContentSize().width*i*1.15, layerGround:getContentSize().height*.81 - 1/resolutionScaleY*wheat[i]:getContentSize().height*2.7)
            layerScreen:addChild(wheat[i+39])
            wheat[i+39]:setAnchorPoint(.5,0)

            wheatLayer[i+39] = cc.LayerColor:create(cc.c4b(255,255,255,0), visibleSize.width*.05, visibleSize.height*.18)
            wheatLayer[i+39]:setPosition(visibleSize.width*.155 + wheat[i]:getContentSize().width*i*1.15, layerGround:getContentSize().height*.81- 1/resolutionScaleY*wheat[i]:getContentSize().height*2.7)
            layerScreen:addChild(wheatLayer[i+39])
        end
        
        bird = cc.Sprite:create("Images/Wheat/bird_1.png")
        bird:setPosition(visibleSize.width * 0.25, visibleSize.height * 0.95)
        layerScreen:addChild(bird)

        bird_tex1 = cc.Sprite:create("Images/Wheat/bird_1.png"):getTexture()
        bird_tex2 = cc.Sprite:create("Images/Wheat/bird_2.png"):getTexture()
        bird_tex3 = cc.Sprite:create("Images/Wheat/bird_3.png"):getTexture()
        flyFrame1=0

        birdFlipped=false
        local function birdFlipXCallback()
            if not birdFlipped then
                birdFlipped = true
            else
                birdFlipped = false
            end
            bird:setFlippedX(birdFlipped)
        end
        bird:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(.1), cc.CallFunc:create(birdFlyCallback) )))
        bird:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.MoveTo:create(1.5,cc.p(visibleSize.width*.95,visibleSize.height*.95)),cc.CallFunc:create(birdFlipXCallback),cc.MoveTo:create(1.5,cc.p(visibleSize.width*.25,visibleSize.height*.95)),cc.CallFunc:create(birdFlipXCallback))))
        for i=1,45 do
            local function onTouchBegan(touch, event)
                if not layerOverDown then
                    local location = touch:getLocation()
                    if wheatLayer[i] then
                        local rect = wheatLayer[i]:getBoundingBox()
                        if cc.rectContainsPoint(rect, location) then
                            --wheatLayer[i]:removeFromParent()
                            selectedWheat=i
                            if math.random(3) == 1 then
                                selectedWheatIsStuck=true
                            end
                        end
                    end
                end
                -- CCTOUCHBEGAN event must return true
                return true
            end
            local function onTouchMoved(touch, event)
                local location = touch:getLocation()
                if selectedWheat then
                    angle = angleInDegreesBetweenLineFromPoint_toPoint_toLineFromPoint_toPoint(cc.p(wheat[selectedWheat]:getPositionX(),wheat[selectedWheat]:getPositionY()),location,cc.p(visibleSize.width*.5,visibleSize.height*-30),cc.p(visibleSize.width*.5,visibleSize.height*30))
                    wheat[selectedWheat]:setRotation(angle)
                    if not selectedWheatIsStuck then
                        if distanceBetweenPointAndPoint(cc.p(wheat[selectedWheat]:getPositionX(),wheat[selectedWheat]:getPositionY()), location) > visibleSize.height*.30 then
                            cc.SimpleAudioEngine:getInstance():playEffect("Sounds/Effects/wheat/wheat_touch.mp3")
                            wheat[selectedWheat]:removeFromParent(true)
                            wheat[selectedWheat]=nil
                            wheatLayer[selectedWheat]:removeFromParent(true)
                            selectedWheat=nil
                            wheatPoints=moveToken(wheatPoints+5)
                            if wheatPoints == 100 and not wonYet then
                                wheatScene:runAction(cc.Sequence:create(cc.DelayTime:create(.3), cc.CallFunc:create(winWheatCallback)))
                            end
                        end
                    else
                        wheat[selectedWheat]:setColor(cc.c4b(230, 25, 25, 255))
                    end
                end
            end
            local function onTouchEnded(touch, event)
                if selectedWheat then
                    wheat[selectedWheat]:setRotation(0)
                    wheat[selectedWheat]:setColor(cc.c4b(255, 255, 255, 0))
                    selectedWheat=nil
                    selectedWheatIsStuck=nil
                end
            end
            local listener = cc.EventListenerTouchOneByOne:create()
            listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
            listener:registerScriptHandler(onTouchMoved,cc.Handler.EVENT_TOUCH_MOVED )
            listener:registerScriptHandler(onTouchEnded,cc.Handler.EVENT_TOUCH_ENDED )
            local eventDispatcher = wheatLayer[i]:getEventDispatcher()
            eventDispatcher:addEventListenerWithSceneGraphPriority(listener, wheatLayer[i]) 
        end
    end
    layerScreen.restartGame(true)


    
    return layerScreen
end
