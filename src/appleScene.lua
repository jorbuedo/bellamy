require "tableLayer"
require "gameCommon"

function overAppleCallback()
    appleScene:cleanup()
    appleScene:addChild(createLayerGameOver(cc.Sprite:create("Images/Apple/apple_over.png")))
end

function winAppleCallback()
    appleScene:cleanup()
    appleScene:addChild(createLayerGameWin("Apple"))
end
function pigFlipXCallback()
    if not pigFlipped then
        pigFlipped = true
    else
        pigFlipped = false
    end
    pig:setFlippedX(pigFlipped)
end
local function pigShapeCallback()
    if walkFrame1%2 == 0 then
        pig:setTexture(pig_tex1)
    else
        pig:setTexture(pig_tex2)
    end
    walkFrame1=walkFrame1+1
end
function eatAppleCallback()
    nextApple:removeFromParent(true)
    nextApple=nil
    --nextApple:setVisible(false)
end
function nextAppleFall()
    prev,nextApple = next(apple,prev)
    if not nextApple then prev,nextApple = next(apple) end

    local nextAppleX = nextApple:getPositionX()
    nextApple:runAction(cc.Sequence:create(cc.RotateBy:create(.1, 20),cc.RotateBy:create(.1, -30),cc.RotateBy:create(.1, 20),cc.RotateBy:create(.1, -10), cc.MoveTo:create(.5, cc.p(nextAppleX, visibleSize.height*.1)), cc.DelayTime:create(.5),cc.CallFunc:create(eatAppleCallback)))     
    pigMovement = cc.Sequence:create(cc.MoveTo:create(1.4,cc.p(nextAppleX,visibleSize.height*.1)),cc.CallFunc:create(pigFlipXCallback),cc.MoveTo:create(.9,cc.p(visibleSize.width*.95,visibleSize.height*.1)),cc.CallFunc:create(pigFlipXCallback))
    pig:runAction(pigMovement)
end
function startApple()
    --math.randomseed(os.time().min)
    prev = math.random(9)
    applePoints = moveToken(0)
    walkFrame1=0
    appleScene:cleanup()
    startClock(30)
    appleScene:runAction(cc.Repeat:create(cc.Sequence:create(cc.DelayTime:create(3.3), cc.CallFunc:create(nextAppleFall)),9))
    appleScene:runAction(cc.Sequence:create(cc.DelayTime:create(30), cc.CallFunc:create(overAppleCallback)))
    pigFlipped=nil
    pig:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(.3), cc.CallFunc:create(pigShapeCallback))))
end
function appleView()
    
    appleScene = cc.Scene:createWithExit()
    layerLeft = createLayerLeft(startApple,"Images/Apple/apple.png")
    appleScene:addChild(layerLeft)
    layerGame = createLayerAppleGame()
    appleScene:addChild(layerGame)
    local info_wood = cc.Sprite:create("Images/Apple/info_wood.png")
    appleScene:addChild(createLayerInfoWood(info_wood, startApple))
    appleScene:addChild(createLayerClock())


    cc.SimpleAudioEngine:getInstance():stopMusic(true)
    cc.SimpleAudioEngine:getInstance():playMusic("Sounds/Music/Game1.mp3", true)
    return appleScene
end

function createLayerAppleGame()
    layerScreen = cc.Layer:create()


    function layerScreen.restartGame (first)
        if not first then
            layerScreen:removeAllChildren()
        end
        local layerSky = cc.LayerColor:create(cc.c4b(107,167,219,255), visibleSize.width*.85, visibleSize.height)
        layerSky:setPosition(visibleSize.width*.15, 0)
        layerScreen:addChild(layerSky)
    
        local apple_tree = cc.Sprite:create("Images/Apple/apple_tree.png")
        apple_tree:setPosition(visibleSize.width * 0.5, -apple_tree:getContentSize().height*.1)
        apple_tree:setAnchorPoint(.5,0)
        layerScreen:addChild(apple_tree)
        local layerGround = cc.LayerColor:create(cc.c4b(162,192,57,255), visibleSize.width*.85, visibleSize.height*.075)
        layerGround:setPosition(visibleSize.width * 0.15, 0)
        layerScreen:addChild(layerGround)    
        apple = {}
    
        local appleWidth = {
            [1] = visibleSize.width*0.35,
            [2] = visibleSize.width*0.56,
            [3] = visibleSize.width*0.41,
            [4] = visibleSize.width*0.46,
            [5] = visibleSize.width*0.33,
            [6] = visibleSize.width*0.49,
            [7] = visibleSize.width*0.66,
            [8] = visibleSize.width*0.52,
            [9] = visibleSize.width*0.61,
        }
    
        local appleHeight = {
            [1] = resolutionScaleY*visibleSize.height * 0.45,
            [2] = resolutionScaleY*visibleSize.height * 0.65,
            [3] = resolutionScaleY*visibleSize.height * 0.6,
            [4] = resolutionScaleY*visibleSize.height * 0.5,
            [5] = resolutionScaleY*visibleSize.height * 0.65,
            [6] = resolutionScaleY*visibleSize.height * 0.73,
            [7] = resolutionScaleY*visibleSize.height * 0.62,
            [8] = resolutionScaleY*visibleSize.height * 0.4,
            [9] = resolutionScaleY*visibleSize.height * 0.47,
        }
    
        for i=1,9 do
            apple[i] = cc.Sprite:create("Images/Apple/apple.png")
            apple[i]:setScale(.8)
            apple[i]:setPosition(appleWidth[i], appleHeight[i])
            layerScreen:addChild(apple[i])
        end
    
    
        pig = cc.Sprite:create("Images/Apple/pig_1.png")
        layerScreen:addChild(pig)
        pig:setPosition(visibleSize.width*.95, visibleSize.height * 0.1)
    
        pig_tex1 = cc.Sprite:create("Images/Apple/pig_1.png"):getTexture()
        pig_tex2 = cc.Sprite:create("Images/Apple/pig_2.png"):getTexture()
    

            -- handing touch events

    end
    layerScreen.restartGame(true)
    local function pigOingCallback()
        cc.SimpleAudioEngine:getInstance():playEffect("Sounds/Effects/apple/pig_touch.mp3")
    end
    local function onTouchBegan(touch, event)
        local location = touch:getLocation()
        local rect   = pig:getBoundingBox()
        if cc.rectContainsPoint(rect, location) then
            pig:runAction(cc.Sequence:create(cc.ScaleTo:create(.1,.6),cc.CallFunc:create(pigOingCallback),cc.ScaleTo:create(.1,1)))
        end
        if nextApple then
            local rect   = nextApple:getBoundingBox()
            if location.y<visibleSize.height*.15 and cc.rectContainsPoint(rect, location) then
                cc.SimpleAudioEngine:getInstance():playEffect("Sounds/Effects/apple/apple_touch.mp3")
                nextApple:runAction(cc.Sequence:create(cc.ScaleBy:create(.1, .1), cc.CallFunc:create(eatAppleCallback)))
                applePoints = moveToken(applePoints+17)
                if applePoints == 100 then
                    appleScene:runAction(cc.Sequence:create(cc.DelayTime:create(.3), cc.CallFunc:create(winAppleCallback)))
                end
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
