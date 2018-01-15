require "explanationScene"

function preLoadExplanation()
    local boy = cc.Sprite:create("Images/Explanation/boy.png")
    local bubble = cc.Sprite:create("Images/Explanation/bubble.png")
    local Kitchen = cc.Sprite:create("Images/Explanation/Kitchen.png")
    local medal_bubble = cc.Sprite:create("Images/Explanation/medal_bubble.png")
    cc.SimpleAudioEngine:getInstance():preloadEffect("Sounds/Effects/click.mp3")
end
function menuView()
    local initScene = cc.Scene:createWithExit()
    initScene:addChild(createLayerBlueSky())
    initScene:addChild(createLayerClouds())
    initScene:addChild(createLayerFarm())
    -- play background music, preload effect
    cc.SimpleAudioEngine:getInstance():stopMusic(true)
    cc.SimpleAudioEngine:getInstance():playMusic("Sounds/Music/MainMusic.mp3", true)
    preLoadExplanation()

    return initScene
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
    clouds:setPosition(visibleSize.width / 2, visibleSize.height)
    clouds:setAnchorPoint(.5,1)
    layerClouds:addChild(clouds)

    local clouds2 = cc.Sprite:create("Images/Init/clouds.png")
    clouds2:setPosition(visibleSize.width + visibleSize.width / 2, visibleSize.height)
    clouds2:setAnchorPoint(.5,1)
    clouds:addChild(clouds2)

    clouds:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.MoveBy:create(60, cc.p(-1*visibleSize.width,0)), cc.MoveBy:create(0, cc.p(visibleSize.width,0)))))

    return layerClouds
end

    -- create farm
function createLayerFarm()
    local layerFarm = cc.Layer:create()

    -- add in farm background
    local bg = cc.Sprite:create("Images/Init/Back.png")
    bg:setPosition(0, 0)
    bg:setAnchorPoint(0,0)
    layerFarm:addChild(bg)

    local title = cc.Sprite:create("Images/Init/banner.png")
    title:setPosition(0, visibleSize.height)
    title:setAnchorPoint(0,1)
    layerFarm:addChild(title)

    local play = cc.Sprite:create("Images/Init/play.png")
    play:setPosition(visibleSize.width - play:getContentSize().width/2, - play:getContentSize().height/2)
    layerFarm:addChild(play)

    local goUp = cc.Sequence:create(cc.MoveBy:create(1, cc.p(0,play:getContentSize().height*0.8)))
    play:runAction(goUp)

    local tinted = false
        -- handing touch events
    local function onTouchBegan(touch, event)
        local location = touch:getLocation()
        local rect   = play:getBoundingBox()
        if cc.rectContainsPoint(rect, location) then
            if not tinted then
                tinted = true
                play:runAction(cc.Sequence:create(cc.MoveBy:create(0.2, cc.p(0,play:getContentSize().height*0.1))))
                play:setColor(cc.c3b(77, 77, 77))
            end
        end
        -- CCTOUCHBEGAN event must return true
        return true
    end
    local function onTouchMoved(touch, event)
        local location = touch:getLocation()
        local rect   = play:getBoundingBox()
        if not cc.rectContainsPoint(rect, location) and tinted then
            tinted = false
            play:runAction(cc.Sequence:create(cc.MoveBy:create(0.2, cc.p(0,play:getContentSize().height*-0.1))))
            play:setColor(cc.c3b(255, 255, 255))
        end
    end
    local function onTouchEnded(touch, event)
        local location = touch:getLocation()
        local rect   = play:getBoundingBox()
        if cc.rectContainsPoint(rect, location) and tinted then
            cc.SimpleAudioEngine:getInstance():playEffect("Sounds/Effects/click.mp3")
            play:runAction(cc.Sequence:create(cc.MoveBy:create(1, cc.p(0,-play:getContentSize().height))))
            explanationScene = explanationView()
            cc.Director:getInstance():replaceScene( cc.TransitionFade:create(1, explanationScene, cc.c3b(0,0,0)) )
        end
    end

    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
    listener:registerScriptHandler(onTouchMoved,cc.Handler.EVENT_TOUCH_MOVED )
    listener:registerScriptHandler(onTouchEnded,cc.Handler.EVENT_TOUCH_ENDED )

    local eventDispatcher = layerFarm:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, layerFarm)


    return layerFarm
end
