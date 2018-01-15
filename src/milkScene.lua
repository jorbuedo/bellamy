require "gameCommon"

function overMilkCallback()
    milkScene:cleanup()
    milkScene:addChild(createLayerGameOver(cc.Sprite:create("Images/Milk/milk_over.png")))
end
function winMilkCallback()
    milkScene:cleanup()
    milkScene:addChild(createLayerGameWin("Milk"))
end

function prepareMilkCallback()
    tit[selectedTit]:setTexture(tit_tex[prepareFrame])
    prepareFrame=prepareFrame+1
    if prepareFrame==5 then
        prepareFrame = 1
    end
end

function spitMilkCallback()
    tit[spitingTit]:setTexture(tit_tex[spitFrame])
    spitFrame=spitFrame+1
    if spitFrame==9 then
        spitFrame = 1
        milkPoints=moveToken(milkPoints+5)
        if milkPoints== 100 then milkScene:runAction(cc.Sequence:create(cc.DelayTime:create(.3), cc.CallFunc:create(winMilkCallback))) end
    end
end

function nextMilkFall()
    prevTit=selectedTit
    selectedTit = math.random(4)
    if selectedTit == prevTit then selectedTit = prevTit +1 end
    if selectedTit==5 then selectedTit = 1 end

    tit[selectedTit]:runAction(cc.Sequence:create(cc.DelayTime:create(.1), cc.CallFunc:create(prepareMilkCallback)))
    tit[selectedTit]:runAction(cc.Sequence:create(cc.DelayTime:create(.2), cc.CallFunc:create(prepareMilkCallback)))
    tit[selectedTit]:runAction(cc.Sequence:create(cc.DelayTime:create(.3), cc.CallFunc:create(prepareMilkCallback)))
    tit[selectedTit]:runAction(cc.Sequence:create(cc.DelayTime:create(.8), cc.CallFunc:create(prepareMilkCallback)))
    prepareFrame=2
end

function startMilk()
    milkScene:cleanup()
    milkPoints=moveToken(0)
    startClock(30)
    milkScene:runAction(cc.Sequence:create(cc.DelayTime:create(30), cc.CallFunc:create(overMilkCallback)))
    milkScene:runAction(cc.Repeat:create(cc.Sequence:create(cc.DelayTime:create(.9), cc.CallFunc:create(nextMilkFall)),40))
end

function milkView()
    milkScene = cc.Scene:createWithExit()
    layerLeft = createLayerLeft(startMilk,"Images/Milk/milk_cup.png")
    milkScene:addChild(layerLeft)
    layerGame = createLayerMilkGame()
    milkScene:addChild(layerGame)
    local info_wood = cc.Sprite:create("Images/Milk/info_wood.png")
    milkScene:addChild(createLayerInfoWood(info_wood, startMilk))
    milkScene:addChild(createLayerClock())

    cc.SimpleAudioEngine:getInstance():stopMusic(true)
    cc.SimpleAudioEngine:getInstance():playMusic("Sounds/Music/Game2.mp3", true)
    return milkScene
end

function createLayerMilkGame()
    layerScreen = cc.Layer:create()


    function layerScreen.restartGame (first)
        if not first then
            layerScreen:removeAllChildren()
        end
        local layerSky = cc.LayerColor:create(cc.c4b(107,167,219,255), visibleSize.width*.85, visibleSize.height)
        layerSky:setPosition(visibleSize.width*.15, 0)
        layerScreen:addChild(layerSky)
    
        tit = {}
    
        tit[1] = cc.Sprite:create("Images/Milk/tit_1.png")
        tit[1]:setPosition(visibleSize.width * 0.3, visibleSize.height- tit[1]:getContentSize().height * .7)
        layerScreen:addChild(tit[1])
    
        tit[2] = cc.Sprite:create("Images/Milk/tit_1.png")
        tit[2]:setPosition(visibleSize.width * 0.466, visibleSize.height- tit[1]:getContentSize().height * 1)
        layerScreen:addChild(tit[2])
    
        tit[3] = cc.Sprite:create("Images/Milk/tit_1.png")
        tit[3]:setPosition(visibleSize.width * 0.632, visibleSize.height- tit[1]:getContentSize().height * 1)
        layerScreen:addChild(tit[3])
    
        tit[4] = cc.Sprite:create("Images/Milk/tit_1.png")
        tit[4]:setPosition(visibleSize.width * 0.8, visibleSize.height- tit[1]:getContentSize().height * .7)
        layerScreen:addChild(tit[4])
    
        local upper_part = cc.Sprite:create("Images/Milk/upper_part.png")
        upper_part:setPosition(visibleSize.width * 0.55, visibleSize.height - upper_part:getContentSize().height*.5)
        layerScreen:addChild(upper_part)

        tit_tex = {}
        tit_tex[1] = cc.Sprite:create("Images/Milk/tit_1.png"):getTexture()
        tit_tex[2] = cc.Sprite:create("Images/Milk/tit_2.png"):getTexture()
        tit_tex[3] = cc.Sprite:create("Images/Milk/tit_3.png"):getTexture()
        tit_tex[4] = cc.Sprite:create("Images/Milk/tit_4.png"):getTexture()
        tit_tex[5] = cc.Sprite:create("Images/Milk/tit_5.png"):getTexture()
        tit_tex[6] = cc.Sprite:create("Images/Milk/tit_6.png"):getTexture()
        tit_tex[7] = cc.Sprite:create("Images/Milk/tit_7.png"):getTexture()
        tit_tex[8] = cc.Sprite:create("Images/Milk/tit_8.png"):getTexture()

        rawMilk = {}
        for i=1,4 do
            local rawMilkClipLayer = cc.LayerColor:create(cc.c4b(255, 255, 255, 0),tit[i]:getContentSize().width * 0.1, visibleSize.height*.6)
            rawMilkClipLayer:setPosition(tit[i]:getContentSize().width*.45, -visibleSize.height*.56)
            tit[i]:addChild(rawMilkClipLayer)
            rawMilkClipLayer:setAnchorPoint(cc.p(.5,0))

            local rawMilkClip = cc.ClippingNode:create(rawMilkClipLayer)
            tit[i]:addChild(rawMilkClip)

            rawMilk[i] = cc.LayerColor:create(cc.c4b(255, 255, 255,255),tit[i]:getContentSize().width * 0.08, tit[i]:getContentSize().height*.5)
            rawMilk[i]:setPosition(tit[i]:getContentSize().width*.458, tit[i]:getContentSize().height*.2)
            rawMilkClip:addChild(rawMilk[i])
            rawMilk[i]:setAnchorPoint(cc.p(.5,0))
        
            local circle1 = cc.Sprite:create("Generators/confetti-02.png")
            circle1:setColor(cc.c3b(255, 255, 255))
            rawMilk[i]:addChild(circle1)
            circle1:setPosition(rawMilk[i]:getContentSize().width*.5, rawMilk[i]:getContentSize().height)
            circle1:setScale(.085)
            local circle2 = cc.Sprite:create("Generators/confetti-02.png")
            circle2:setColor(cc.c3b(255, 255, 255))
            rawMilk[i]:addChild(circle2)
            circle2:setPosition(rawMilk[i]:getContentSize().width*.5, 0)
            circle2:setScale(.085)
        end

        titMissCount=0
        function titMissedAuch()
            titMissCount=titMissCount+1
            if titMissCount == 3 then
                titMissCount=0
                milkPoints=moveToken(milkPoints-20)
            end
        end
        function spitTit(num)
            spitingTit=num
            tit[num]:cleanup()
            spitFrame=5
            rawMilk[num]:runAction(cc.Sequence:create(cc.MoveBy:create(.7,cc.p(0,-visibleSize.height*.5)), cc.MoveBy:create(0,cc.p(0,visibleSize.height*.5))))
            tit[num]:runAction(cc.Sequence:create(cc.DelayTime:create(.1), cc.CallFunc:create(spitMilkCallback)))
            tit[num]:runAction(cc.Sequence:create(cc.DelayTime:create(.2), cc.CallFunc:create(spitMilkCallback)))
            tit[num]:runAction(cc.Sequence:create(cc.DelayTime:create(.3), cc.CallFunc:create(spitMilkCallback)))
            tit[num]:runAction(cc.Sequence:create(cc.DelayTime:create(.4), cc.CallFunc:create(spitMilkCallback)))
            tit[num]:runAction(cc.Sequence:create(cc.DelayTime:create(.5), cc.CallFunc:create(spitMilkCallback)))
        end
        titTouched = {
            [1] = function() if selectedTit ~= 1 then titMissedAuch(); tit[1]:runAction(cc.Sequence:create(cc.TintTo:create(.1, 230, 25, 25), cc.DelayTime:create(.2), cc.TintTo:create(.1,255,255,255))) else spitTit(1) end end,
            [2] = function() if selectedTit ~= 2 then titMissedAuch(); tit[2]:runAction(cc.Sequence:create(cc.TintTo:create(.1, 230, 25, 25), cc.DelayTime:create(.2), cc.TintTo:create(.1,255,255,255))) else spitTit(2) end end,
            [3] = function() if selectedTit ~= 3 then titMissedAuch(); tit[3]:runAction(cc.Sequence:create(cc.TintTo:create(.1, 230, 25, 25), cc.DelayTime:create(.2), cc.TintTo:create(.1,255,255,255))) else spitTit(3) end end,
            [4] = function() if selectedTit ~= 4 then titMissedAuch(); tit[4]:runAction(cc.Sequence:create(cc.TintTo:create(.1, 230, 25, 25), cc.DelayTime:create(.2), cc.TintTo:create(.1,255,255,255))) else spitTit(4) end end,
        }
    end
    layerScreen.restartGame(true)

                -- handing touch events
    local function onTouchBegan(touch, event)
        if not layerOverDown then
            local location = touch:getLocation()
            local rect   = tit[1]:getBoundingBox()
            if cc.rectContainsPoint(rect, location) then
                titTouched[1]()
            end
            rect   = tit[2]:getBoundingBox()
            if cc.rectContainsPoint(rect, location) then
                titTouched[2]()
            end
            rect   = tit[3]:getBoundingBox()
            if cc.rectContainsPoint(rect, location) then
                titTouched[3]()
            end
            rect   = tit[4]:getBoundingBox()
            if cc.rectContainsPoint(rect, location) then
                titTouched[4]()
            end
        end
        -- CCTOUCHBEGAN event must return true
        return true
    end

    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
    local eventDispatcher = layerScreen:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, layerScreen)
    return layerScreen
end
