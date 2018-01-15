require "appleScene"
require "chocolateScene"
require "eggScene"
require "milkScene"
require "cookingScene"
require "strawberryScene"
require "wheatScene"
require "gameCommon"
require "tableLayer"

function mapView()
    unique = true
    
    mapScene = cc.Scene:createWithExit()
    mapScene:addChild(createLayerBlueSky())
    mapScene:addChild(createLayerClouds())
    mapScene:addChild(createLayerMap())
    mapScene:addChild(createLayerApple())
    mapScene:addChild(createLayerMilk())
    mapScene:addChild(createLayerStrawberry())
    mapScene:addChild(createLayerChocolate())
    mapScene:addChild(createLayerEgg())
    mapScene:addChild(createLayerWheat())
    mapScene:addChild(createLayerAnimals())

    if stamp_apple_star_won and stamp_chocolate_star_won and stamp_egg_star_won and stamp_milk_star_won and stamp_strawberry_star_won and stamp_wheat_star_won then
        allGamesFinished()
    end
    -- play background music, preload effect
    --cc.SimpleAudioEngine:getInstance():stopMusic(true)
    --cc.SimpleAudioEngine:getInstance():playMusic("Sounds/Music/MainMusic.mp3", true)
    
    cc.SimpleAudioEngine:getInstance():preloadEffect("Sounds/Effects/chocolate/bee.mp3")
    cc.SimpleAudioEngine:getInstance():preloadEffect("Sounds/Effects/apple/pig.aif")
    cc.SimpleAudioEngine:getInstance():preloadEffect("Sounds/Effects/milk/cow.aif")
    cc.SimpleAudioEngine:getInstance():preloadEffect("Sounds/Effects/egg/chicken.aif")
    cc.SimpleAudioEngine:getInstance():preloadEffect("Sounds/Effects/wheat/bird.aif")
    cc.SimpleAudioEngine:getInstance():preloadEffect("Sounds/Effects/info_down.mp3")
    cc.SimpleAudioEngine:getInstance():preloadEffect("Sounds/Effects/info_up.mp3")

    return mapScene
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

local function objectTouched(touch, inLayer)
    local location = touch:getLocation()
    for k, v in pairs(inLayer:getChildren()) do
        local rect = v:getBoundingBox()
        if cc.rectContainsPoint(rect, location) then
            return true
        end
    end
    return false
end
local function tintInLayer(inLayer, tinted)
    for k, v in pairs(inLayer:getChildren()) do
        if tinted then
            v:setColor(cc.c3b(255, 255, 255))
        else
            v:setColor(cc.c3b(77, 77, 77))
        end
    end
    return false
end

function createLayerApple()
    local layerApple = cc.Layer:create()

    local apple_tree = cc.Sprite:create("Images/Map/apple_tree.png")
    apple_tree:setPosition(visibleSize.width * 0.42, resolutionScaleY*visibleSize.height * 0.57)
    layerApple:addChild(apple_tree)
    local apple_poster = cc.Sprite:create("Images/Map/apple_poster.png")
    apple_poster:setPosition(visibleSize.width * 0.47, resolutionScaleY*visibleSize.height * 0.4)
    layerApple:addChild(apple_poster)



    local tinted =  false
        -- handing touch events
    local function onTouchBegan(touch, event)
        if objectTouched(touch, layerApple) then
            if not tinted then
                tintInLayer(layerApple, tinted)
                tinted = true
            end
        end
        -- CCTOUCHBEGAN event must return true
        return true
    end
    local function onTouchMoved(touch, event)
        if not objectTouched(touch, layerApple) then
            if tinted then
                tintInLayer(layerApple, tinted)
                tinted = false
            end
        end
    end
    local function onTouchEnded(touch, event)
        if objectTouched(touch, layerApple) then
            if unique and not stamp_apple_star_won then
                cc.SimpleAudioEngine:getInstance():playEffect("Sounds/Effects/apple/pig.aif")
                unique = nil
                appleScene = appleView()
                cc.Director:getInstance():pushScene(appleScene )
                cc.Director:getInstance():pushScene( cc.TransitionSlideInT:create(1, loadGameScene("Apple")) )
            end
            tintInLayer(layerApple, tinted)
            tinted = false
        end
    end

    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
    listener:registerScriptHandler(onTouchMoved,cc.Handler.EVENT_TOUCH_MOVED )
    listener:registerScriptHandler(onTouchEnded,cc.Handler.EVENT_TOUCH_ENDED )
    local eventDispatcher = layerApple:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, layerApple)


    return layerApple
end

function createLayerChocolate()
    local layerChocolate = cc.Layer:create()

    local chocolate_tree = cc.Sprite:create("Images/Map/chocolate_tree.png")
    chocolate_tree:setPosition(visibleSize.width * 0.34, resolutionScaleY*visibleSize.height * 0.23)
    layerChocolate:addChild(chocolate_tree)
    local chocolate_poster = cc.Sprite:create("Images/Map/chocolate_poster.png")
    chocolate_poster:setPosition(visibleSize.width * 0.43, resolutionScaleY*visibleSize.height *0.1)
    layerChocolate:addChild(chocolate_poster)



    local tinted =  false
        -- handing touch events
    local function onTouchBegan(touch, event)
        if objectTouched(touch, layerChocolate) then
            if not tinted then
                tintInLayer(layerChocolate, tinted)
                tinted = true
            end
        end
        -- CCTOUCHBEGAN event must return true
        return true
    end
    local function onTouchMoved(touch, event)
        if not objectTouched(touch, layerChocolate) then
            if tinted then
                tintInLayer(layerChocolate, tinted)
                tinted = false
            end
        end
    end
    local function onTouchEnded(touch, event)
        if objectTouched(touch, layerChocolate) and unique and not stamp_chocolate_star_won then
            cc.SimpleAudioEngine:getInstance():playEffect("Sounds/Effects/chocolate/bee.mp3")
            unique = nil
            chocolateScene = chocolateView()
            cc.Director:getInstance():pushScene(chocolateScene )
            cc.Director:getInstance():pushScene( cc.TransitionSlideInT:create(1, loadGameScene("Chocolate")) )
            tintInLayer(layerChocolate, tinted)
            tinted = true
        end
    end

    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
    listener:registerScriptHandler(onTouchMoved,cc.Handler.EVENT_TOUCH_MOVED )
    listener:registerScriptHandler(onTouchEnded,cc.Handler.EVENT_TOUCH_ENDED )
    local eventDispatcher = layerChocolate:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, layerChocolate)


    return layerChocolate
end

function createLayerMilk()
    local layerMilk = cc.Layer:create()


    local cow = cc.Sprite:create("Images/Map/cow.png")
    cow:setPosition(visibleSize.width * 0.13, resolutionScaleY*visibleSize.height * 0.59)
    layerMilk:addChild(cow)
    local cow_tail = cc.Sprite:create("Images/Map/cow_tail.png")
    cow:addChild(cow_tail)
    cow_tail:setAnchorPoint(.1, 0)
    cow_tail:setPosition(cow:getContentSize().width*.76, cow:getContentSize().height*.63)
    cow_tail:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.RotateBy:create(1,-40), cc.RotateBy:create(1,40))))

    local milk_poster = cc.Sprite:create("Images/Map/milk_poster.png")
    milk_poster:setPosition(visibleSize.width * 0.21, resolutionScaleY*visibleSize.height * 0.52)
    layerMilk:addChild(milk_poster)

    local tinted =  false
        -- handing touch events
    local function onTouchBegan(touch, event)
        if objectTouched(touch, layerMilk) then
            if not tinted then
                tintInLayer(layerMilk, tinted)
                tinted = true
            end
        end
        -- CCTOUCHBEGAN event must return true
        return true
    end
    local function onTouchMoved(touch, event)
        if not objectTouched(touch, layerMilk) then
            if tinted then
                tintInLayer(layerMilk, tinted)
                tinted = false
            end
        end
    end
    local function onTouchEnded(touch, event)
        if objectTouched(touch, layerMilk) and unique and not stamp_milk_star_won then
            cc.SimpleAudioEngine:getInstance():playEffect("Sounds/Effects/milk/cow.aif")
            unique = nil
            milkScene = milkView()
            cc.Director:getInstance():pushScene(milkScene )
            cc.Director:getInstance():pushScene( cc.TransitionSlideInT:create(1, loadGameScene("Milk")) )
            tintInLayer(layerMilk, tinted)
            tinted = true
        end
    end

    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
    listener:registerScriptHandler(onTouchMoved,cc.Handler.EVENT_TOUCH_MOVED )
    listener:registerScriptHandler(onTouchEnded,cc.Handler.EVENT_TOUCH_ENDED )
    local eventDispatcher = layerMilk:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, layerMilk)


    return layerMilk
end

function createLayerEgg()
    local layerEgg = cc.Layer:create()


    local chicken_1 = cc.Sprite:create("Images/Map/chicken_1.png")
    chicken_1:setPosition(visibleSize.width * 0.6, resolutionScaleY*visibleSize.height * 0.12)
    layerEgg:addChild(chicken_1)
    local chicken_2 = cc.Sprite:create("Images/Map/chicken_2.png")
    chicken_2:setPosition(visibleSize.width * 0.72, resolutionScaleY*visibleSize.height * 0.08)
    layerEgg:addChild(chicken_2)
    local chicken_3 = cc.Sprite:create("Images/Map/chicken_3.png")
    chicken_3:setPosition(visibleSize.width * 0.65, resolutionScaleY*visibleSize.height * 0.07)
    layerEgg:addChild(chicken_3)
    chicken_3:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(3),cc.MoveBy:create(.2,cc.p(0,chicken_3:getContentSize().height*.5)),cc.MoveBy:create(.2,cc.p(0,-chicken_3:getContentSize().height*.5)))))

    local chicken_21 = cc.Sprite:create("Images/Map/chicken_1.png")
    chicken_21:setPosition(visibleSize.width * 0.85, resolutionScaleY*visibleSize.height * 0.15)
    layerEgg:addChild(chicken_21)
    chicken_21:setFlippedX(true)
    chicken_21:setScale(.8)
    local chicken_22 = cc.Sprite:create("Images/Map/chicken_2.png")
    chicken_22:setPosition(visibleSize.width * 0.72, resolutionScaleY*visibleSize.height * 0.2)
    layerEgg:addChild(chicken_22)
    chicken_22:setFlippedX(true)
    chicken_22:setScale(.8)
    local chicken_23 = cc.Sprite:create("Images/Map/chicken_3.png")
    chicken_23:setPosition(visibleSize.width * 0.79, resolutionScaleY*visibleSize.height * 0.05)
    layerEgg:addChild(chicken_23)
    chicken_23:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.MoveBy:create(.2,cc.p(0,chicken_23:getContentSize().height*.5)),cc.MoveBy:create(.2,cc.p(0,-chicken_23:getContentSize().height*.5)),cc.DelayTime:create(4))))


    local egg_poster = cc.Sprite:create("Images/Map/egg_poster.png")
    egg_poster:setPosition(visibleSize.width * 0.9, resolutionScaleY*visibleSize.height * 0.1)
    layerEgg:addChild(egg_poster)

    local tinted =  false
        -- handing touch events
    local function onTouchBegan(touch, event)
        if objectTouched(touch, layerEgg) then
            if not tinted then
                tintInLayer(layerEgg, tinted)
                tinted = true
            end
        end
        -- CCTOUCHBEGAN event must return true
        return true
    end
    local function onTouchMoved(touch, event)
        if not objectTouched(touch, layerEgg) then
            if tinted then
                tintInLayer(layerEgg, tinted)
                tinted = false
            end
        end
    end
    local function onTouchEnded(touch, event)
        if objectTouched(touch, layerEgg) and unique and not stamp_egg_star_won then
            cc.SimpleAudioEngine:getInstance():playEffect("Sounds/Effects/egg/chicken.aif")
            unique = nil
            eggScene = eggView()
            cc.Director:getInstance():pushScene(eggScene )
            cc.Director:getInstance():pushScene( cc.TransitionSlideInT:create(1, loadGameScene("Egg")) )
            tintInLayer(layerEgg, tinted)
            tinted = true
        end
    end

    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
    listener:registerScriptHandler(onTouchMoved,cc.Handler.EVENT_TOUCH_MOVED )
    listener:registerScriptHandler(onTouchEnded,cc.Handler.EVENT_TOUCH_ENDED )
    local eventDispatcher = layerEgg:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, layerEgg)


    return layerEgg
end

function createLayerWheat()
    local layerWheat = cc.Layer:create()

    local wheat = cc.Sprite:create("Images/Map/wheat.png")
    wheat:setPosition(visibleSize.width * 0.9, resolutionScaleY*visibleSize.height * 0.4)
    layerWheat:addChild(wheat)
    local wheat_poster = cc.Sprite:create("Images/Map/wheat_poster.png")
    wheat_poster:setPosition(visibleSize.width * 0.85, resolutionScaleY*visibleSize.height * 0.36)
    layerWheat:addChild(wheat_poster)

    local tinted =  false
        -- handing touch events
    local function onTouchBegan(touch, event)
        if objectTouched(touch, layerWheat) then
            if not tinted then
                tintInLayer(layerWheat, tinted)
                tinted = true
            end
        end
        -- CCTOUCHBEGAN event must return true
        return true
    end
    local function onTouchMoved(touch, event)
        if not objectTouched(touch, layerWheat) then
            if tinted then
                tintInLayer(layerWheat, tinted)
                tinted = false
            end
        end
    end
    local function onTouchEnded(touch, event)
        if objectTouched(touch, layerWheat) and unique and not stamp_wheat_star_won then
            cc.SimpleAudioEngine:getInstance():playEffect("Sounds/Effects/wheat/bird.aif")
            unique = nil
            wheatScene = wheatView()
            cc.Director:getInstance():pushScene(wheatScene )
            cc.Director:getInstance():pushScene( cc.TransitionSlideInT:create(1, loadGameScene("Wheat")) )
            tintInLayer(layerWheat, tinted)
            tinted = true
        end
    end

    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
    listener:registerScriptHandler(onTouchMoved,cc.Handler.EVENT_TOUCH_MOVED )
    listener:registerScriptHandler(onTouchEnded,cc.Handler.EVENT_TOUCH_ENDED )
    local eventDispatcher = layerWheat:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, layerWheat)


    return layerWheat
end

function createLayerStrawberry()
    local layerStrawberry = cc.Layer:create()

    local strawberry_tree = cc.Sprite:create("Images/Map/strawberry_tree.png")
    strawberry_tree:setPosition(visibleSize.width * 0.2, resolutionScaleY*visibleSize.height * 0.42)
    layerStrawberry:addChild(strawberry_tree)
    local strawberry_poster = cc.Sprite:create("Images/Map/strawberry_poster.png")
    strawberry_poster:setPosition(visibleSize.width * 0.07, resolutionScaleY*visibleSize.height * 0.37)
    layerStrawberry:addChild(strawberry_poster)

    local tinted =  false
        -- handing touch events
    local function onTouchBegan(touch, event)
        if objectTouched(touch, layerStrawberry) then
            if not tinted then
                tintInLayer(layerStrawberry, tinted)
                tinted = true
            end
        end
        -- CCTOUCHBEGAN event must return true
        return true
    end
    local function onTouchMoved(touch, event)
        if not objectTouched(touch, layerStrawberry) then
            if tinted then
                tintInLayer(layerStrawberry, tinted)
                tinted = false
            end
        end
    end
    local function onTouchEnded(touch, event)
        if objectTouched(touch, layerStrawberry) and unique and not stamp_strawberry_star_won then
            unique = nil
            strawberryScene = strawberryView()
            cc.Director:getInstance():pushScene(strawberryScene )
            cc.Director:getInstance():pushScene( cc.TransitionSlideInT:create(1, loadGameScene("Strawberry")) )
            tintInLayer(layerStrawberry, tinted)
            tinted = true
        end
    end

    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
    listener:registerScriptHandler(onTouchMoved,cc.Handler.EVENT_TOUCH_MOVED )
    listener:registerScriptHandler(onTouchEnded,cc.Handler.EVENT_TOUCH_ENDED )
    local eventDispatcher = layerStrawberry:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, layerStrawberry)


    return layerStrawberry
end

function createLayerAnimals()
    local layerAnimals = cc.Layer:create()

    local cat = cc.Sprite:create("Images/Map/cat.png")
    cat:setPosition(visibleSize.width * 0.6, resolutionScaleY* visibleSize.height * 0.65)
    layerAnimals:addChild(cat)
    cat:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(7),cc.MoveBy:create(.5, cc.p(0,cat:getContentSize().height*2)), cc.MoveBy:create(.5, cc.p(0,-cat:getContentSize().height*2)))))
    cat:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(7),cc.RotateBy:create(1,360))))


    local sheep = cc.Sprite:create("Images/Map/sheep_1.png")
    layerAnimals:addChild(sheep)
    sheep:setPosition(visibleSize.width * 0.6, resolutionScaleY*visibleSize.height * 0.35)

    local sheep_tex1 = cc.Sprite:create("Images/Map/sheep_1.png"):getTexture()
    local sheep_tex2 = cc.Sprite:create("Images/Map/sheep_2.png"):getTexture()
    walkFrame1=0
    local function sheepShapeCallback()
        if walkFrame1%2 == 0 then
            sheep:setTexture(sheep_tex1)
        else
            sheep:setTexture(sheep_tex2)
        end
        walkFrame1=walkFrame1+1
    end
    sheep:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(.2), cc.CallFunc:create(sheepShapeCallback))))

    sheepFlipped=false
    local function sheepFlipXCallback()
        if not sheepFlipped then
            sheepFlipped = true
        else
            sheepFlipped = false
        end
        sheep:setFlippedX(sheepFlipped)
    end

    sheepMovement = cc.Speed:create(cc.RepeatForever:create(cc.Sequence:create(cc.MoveBy:create(2,cc.p(-sheep:getContentSize().width*.4,-sheep:getContentSize().height*.4)),cc.CallFunc:create(sheepFlipXCallback),cc.MoveBy:create(2,cc.p(sheep:getContentSize().width*.4,sheep:getContentSize().height*.4)),cc.CallFunc:create(sheepFlipXCallback))), 1)
    sheep:runAction(sheepMovement)


    local dog_body = cc.Sprite:create("Images/Map/dog_body.png")
    dog_body:setPosition(visibleSize.width * 0.08, visibleSize.height * 0.2)
    layerAnimals:addChild(dog_body)
    local dog_head = cc.Sprite:create("Images/Map/dog_head.png")
    dog_body:addChild(dog_head)
    dog_head:setAnchorPoint(.1, 0)
    dog_head:setPosition(dog_body:getContentSize().width*.7, dog_body:getContentSize().height*.45)
    dog_head:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.RotateBy:create(1,-30), cc.RotateBy:create(1,30))))



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
        local location = touch:getLocation()
        local rect_dog = dog_body:getBoundingBox()
        local rect_sheep = sheep:getBoundingBox()
        if cc.rectContainsPoint(rect_dog, location) then
            cc.SimpleAudioEngine:getInstance():playEffect("Sounds/Effects/dog.mp3")
            dog_body:runAction(cc.Sequence:create(cc.MoveBy:create(.5, cc.p(0,dog_body:getContentSize().height*1.5)), cc.MoveBy:create(.5, cc.p(0,-dog_body:getContentSize().height*1.5))))
            dog_body:runAction(cc.Sequence:create(cc.RotateBy:create(1,-360)))
        end
        if cc.rectContainsPoint(rect_sheep, location) then
            cc.SimpleAudioEngine:getInstance():playEffect("Sounds/Effects/sheep.mp3")

        end
    end

    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
    listener:registerScriptHandler(onTouchMoved,cc.Handler.EVENT_TOUCH_MOVED )
    listener:registerScriptHandler(onTouchEnded,cc.Handler.EVENT_TOUCH_ENDED )
    local eventDispatcher = layerAnimals:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, layerAnimals)


    return layerAnimals
end

function createLayerMap()
    local layerMap = cc.Layer:create()

    -- add in farm background
    local bg = cc.Sprite:create("Images/Map/map_back.png")
    bg:setPosition(0, 0)
    bg:setAnchorPoint(0,0)
    layerMap:addChild(bg)
    local basket = cc.Sprite:create("Images/Map/stamp_basket.png")
    basket:setPosition(visibleSize.width - basket:getContentSize().width*.7, visibleSize.height - basket:getContentSize().height*.7)
    layerMap:addChild(basket)


        -- handing touch events
    local function onTouchBegan(touch, event)
        local location = touch:getLocation()
        local rect   = basket:getBoundingBox()
        if cc.rectContainsPoint(rect, location) then
            cc.SimpleAudioEngine:getInstance():playEffect("Sounds/Effects/click.mp3")
            mapScene:addChild(createLayerTable())
        end
        -- CCTOUCHBEGAN event must return true
        return true
    end
    local function onTouchMoved(touch, event)
        local location = touch:getLocation()

    end
    local function onTouchEnded(touch, event)
        local location = touch:getLocation()
        --layerTable = nil
        --cc.Director:getInstance():pushScene( cc.TransitionSlideInT:create(1, selectCakeView()) )
    end

    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
    listener:registerScriptHandler(onTouchMoved,cc.Handler.EVENT_TOUCH_MOVED )
    listener:registerScriptHandler(onTouchEnded,cc.Handler.EVENT_TOUCH_ENDED )
    local eventDispatcher = layerMap:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, layerMap)


    return layerMap
end
