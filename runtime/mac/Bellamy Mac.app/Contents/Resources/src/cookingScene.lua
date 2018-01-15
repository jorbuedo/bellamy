require "partyBadScene"
require "partyGoodScene"

function selectCakeView()
    selectCakeScene = cc.Scene:createWithExit()
    selectCakeScene:addChild(createLayerSelectCake())

    return selectCakeScene
end

function cookingView()
    cookingScene = cc.Scene:createWithExit()
    cookingScene:addChild(createLayerCooking())

    -- play background music, preload effect

    return cookingScene
end

function decoratingView()

    decoratingScene = cc.Scene:createWithExit()
    decoratingScene:addChild(createLayerDecorating())

    -- play background music, preload effect

    return decoratingScene
end


function createLayerSelectCake()
    local layerSelectCake = cc.Layer:create()

    local kitchen_full_back = cc.Sprite:create("Images/Cooking/kitchen_full_back.png")
    kitchen_full_back:setPosition(visibleSize.width * 0.5, visibleSize.height * 0.5)
    layerSelectCake:addChild(kitchen_full_back)

    local selector_machine = cc.Sprite:create("Images/Cooking/step_1/selector_machine.png")
    selector_machine:setPosition(visibleSize.width * 0.5, visibleSize.height * 0.45)
    selector_machine:setScale(1/resolutionScaleY)
    layerSelectCake:addChild(selector_machine)

    local selector_front = cc.Sprite:create("Images/Cooking/step_1/selector_front.png")
    selector_front:setPosition(visibleSize.width * 0.505, selector_machine:getContentSize().height * 0.54)
    selector_front:setScale(.925)
    selector_machine:addChild(selector_front)
    
    local go_loading_button = cc.Sprite:create("Images/Cooking/step_1/go_loading_button.png")
    go_loading_button:setPosition(selector_machine:getContentSize().width * 0.4905, selector_machine:getContentSize().height * 0.202)
    selector_machine:addChild(go_loading_button)

    local go_button = cc.Sprite:create("Images/Cooking/step_1/go_button.png")
    go_button:setPosition(selector_machine:getContentSize().width * 0.4905, selector_machine:getContentSize().height * 0.202)
    selector_machine:addChild(go_button)

    local select_button_r = cc.Sprite:create("Images/Cooking/step_1/select_button.png")
    select_button_r:setPosition(selector_machine:getContentSize().width * 0.8815, selector_machine:getContentSize().height * 0.715)
    selector_machine:addChild(select_button_r)

    local select_button_l = cc.Sprite:create("Images/Cooking/step_1/select_button.png")
    select_button_l:setPosition(selector_machine:getContentSize().width * 0.099, selector_machine:getContentSize().height * 0.715)
    selector_machine:addChild(select_button_l)
    select_button_l:setFlippedX(true)




    local clipNode = cc.ClippingNode:create(selector_front)
    selector_machine:addChild(clipNode)




    local layerCakeArray = cc.LayerColor:create(cc.c4b(255,255,255,0),visibleSize.width*7,visibleSize.height)
    layerCakeArray:setPosition(visibleSize.width * -.06, 0)
    clipNode:addChild(layerCakeArray)

    local cake_1 = cc.Sprite:create("Images/Cooking/cakes/cake_1.png")
    cake_1:setPosition(selector_front:getContentSize().width* 1, selector_machine:getContentSize().height * 0.585)
    layerCakeArray:addChild(cake_1)
    cake_1:setScale(.4)

    local cake_2 = cc.Sprite:create("Images/Cooking/cakes/cake_2.png")
    cake_2:setPosition(selector_front:getContentSize().width * 2, selector_machine:getContentSize().height * 0.585)
    layerCakeArray:addChild(cake_2)
    cake_2:setScale(.4)

    local cake_3 = cc.Sprite:create("Images/Cooking/cakes/cake_3.png")
    cake_3:setPosition(selector_front:getContentSize().width * 3, selector_machine:getContentSize().height * 0.585)
    layerCakeArray:addChild(cake_3)
    cake_3:setScale(.4)

    local cake_4 = cc.Sprite:create("Images/Cooking/cakes/cake_4.png")
    cake_4:setPosition(selector_front:getContentSize().width * 4, selector_machine:getContentSize().height * 0.585)
    layerCakeArray:addChild(cake_4)
    cake_4:setScale(.4)

    local cake_5 = cc.Sprite:create("Images/Cooking/cakes/cake_5.png")
    cake_5:setPosition(selector_front:getContentSize().width * 5, selector_machine:getContentSize().height * 0.585)
    layerCakeArray:addChild(cake_5)
    cake_5:setScale(.4)

    local cake_6 = cc.Sprite:create("Images/Cooking/cakes/cake_6.png")
    cake_6:setPosition(selector_front:getContentSize().width * 6, selector_machine:getContentSize().height * 0.585)
    layerCakeArray:addChild(cake_6)
    cake_6:setScale(.4)

    local cake_7 = cc.Sprite:create("Images/Cooking/cakes/cake_7.png")
    cake_7:setPosition(selector_front:getContentSize().width * 7, selector_machine:getContentSize().height * 0.585)
    layerCakeArray:addChild(cake_7)
    cake_7:setScale(.4)

    local cake_8 = cc.Sprite:create("Images/Cooking/cakes/cake_8.png")
    cake_8:setPosition(selector_front:getContentSize().width * 8, selector_machine:getContentSize().height * 0.585)
    layerCakeArray:addChild(cake_8)
    cake_8:setScale(.4)

    local cake_9 = cc.Sprite:create("Images/Cooking/cakes/cake_9.png")
    cake_9:setPosition(selector_front:getContentSize().width * 9, selector_machine:getContentSize().height * 0.585)
    layerCakeArray:addChild(cake_9)
    cake_9:setScale(.4)

    local cake_10 = cc.Sprite:create("Images/Cooking/cakes/cake_10.png")
    cake_10:setPosition(selector_front:getContentSize().width * 10, selector_machine:getContentSize().height * 0.585)
    layerCakeArray:addChild(cake_10)
    cake_10:setScale(.4)

    local cake_11 = cc.Sprite:create("Images/Cooking/cakes/cake_11.png")
    cake_11:setPosition(selector_front:getContentSize().width * 11, selector_machine:getContentSize().height * 0.585)
    layerCakeArray:addChild(cake_11)
    cake_11:setScale(.4)

    local function goNextCookingCallback()
        cc.Director:getInstance():replaceScene( cc.TransitionSlideInR:create(1, cookingView()) )
    end

    viewing = 1
        local function onTouchBegan(touch, event)
        local location = selector_machine:convertToNodeSpace(touch:getLocation())

        local rect_select_button_r = select_button_r:getBoundingBox()
        local rect_select_button_l = select_button_l:getBoundingBox()
        local rect_go_button = go_button:getBoundingBox()
        if cc.rectContainsPoint(rect_select_button_r, location) then
            select_button_r_tinted = true
            select_button_r:setColor(cc.c3b(91, 199, 215))
        end
        if cc.rectContainsPoint(rect_select_button_l, location) then
            select_button_l_tinted = true
            select_button_l:setColor(cc.c3b(91, 199, 215))
        end
        if cc.rectContainsPoint(rect_go_button, location) then
            go_button_tinted = true
            go_button:setColor(cc.c3b(91, 199, 215))
       end
        -- CCTOUCHBEGAN event must return true
        return true
    end
    local function onTouchMoved(touch, event)
        local location = selector_machine:convertToNodeSpace(touch:getLocation())

        local rect_select_button_r = select_button_r:getBoundingBox()
        local rect_select_button_l = select_button_l:getBoundingBox()
        local rect_go_button = go_button:getBoundingBox()
        if not cc.rectContainsPoint(rect_select_button_r, location) and select_button_r_tinted then
            select_button_r_tinted = false
            select_button_r:setColor(cc.c3b(255, 255, 255))
        end
        if not cc.rectContainsPoint(rect_select_button_l, location) and select_button_l_tinted then
            select_button_l_tinted = false
            select_button_l:setColor(cc.c3b(255, 255, 255))
        end
        if not cc.rectContainsPoint(rect_go_button, location) and go_button_tinted then
            go_button_tinted = false
            go_button:setColor(cc.c3b(255, 255, 255))
       end
    end

        -- handing touch events
    local function onTouchEnded(touch, event)
        local location = selector_machine:convertToNodeSpace(touch:getLocation())

        local rect_select_button_r = select_button_r:getBoundingBox()
        local rect_select_button_l = select_button_l:getBoundingBox()
        local rect_go_button = go_button:getBoundingBox()
        if cc.rectContainsPoint(rect_select_button_r, location) and select_button_r_tinted then
            select_button_r_tinted = false
            select_button_r:setColor(cc.c3b(255, 255, 255))
            cc.SimpleAudioEngine:getInstance():playEffect("Sounds/Effects/click.mp3")
            if viewing<11 then
                cc.SimpleAudioEngine:getInstance():playEffect("Sounds/Effects/info_down.mp3")
                viewing = viewing +1
                layerCakeArray:runAction(cc.EaseInOut:create(cc.MoveBy:create(1, cc.p(-selector_front:getContentSize().width, 0)), 2))
            end
        end
        if cc.rectContainsPoint(rect_select_button_l, location) and select_button_l_tinted then
            select_button_l_tinted = false
            select_button_l:setColor(cc.c3b(255, 255, 255))
            cc.SimpleAudioEngine:getInstance():playEffect("Sounds/Effects/click.mp3")
            if viewing>1 then
                cc.SimpleAudioEngine:getInstance():playEffect("Sounds/Effects/info_up.mp3")
                viewing = viewing -1
                layerCakeArray:runAction(cc.EaseInOut:create(cc.MoveBy:create(1, cc.p(selector_front:getContentSize().width, 0)), 2))
            end
        end
        if cc.rectContainsPoint(rect_go_button, location) and go_button_tinted then
            go_button_tinted = false
            go_button:setColor(cc.c3b(255, 255, 255))
            cc.SimpleAudioEngine:getInstance():playEffect("Sounds/Effects/click.mp3")
            go_button:setVisible(false)
            go_loading_button:runAction(cc.RotateBy:create(2, 720))
            go_loading_button:runAction(cc.Sequence:create(cc.DelayTime:create(1), cc.CallFunc:create(goNextCookingCallback)))
        end
        --cc.Director:getInstance():replaceScene( cc.TransitionSlideInR:create(1, cookingView()) )

        
    end

    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
    listener:registerScriptHandler(onTouchMoved,cc.Handler.EVENT_TOUCH_MOVED )
    listener:registerScriptHandler(onTouchEnded,cc.Handler.EVENT_TOUCH_ENDED )
    local eventDispatcher = layerSelectCake:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, layerSelectCake)


    return layerSelectCake
end

function deleteFallingMedalsCallback()
    layerFallingMedals:removeFromParent(true)
end
function playEffectFallingMedalsCallback()
    cc.SimpleAudioEngine:getInstance():playEffect("Sounds/Effects/final_part/medals.mp3")
end
function createLayerFallingMedals()
    layerFallingMedals = cc.Layer:create()

    local medalsLayerClip = cc.LayerColor:create(cc.c4b(255,255,255,0),visibleSize.width*.2, visibleSize.height*.4)
    medalsLayerClip:setPosition(visibleSize.width*.06, resolutionScaleY*visibleSize.height*.745)
    layerFallingMedals:addChild(medalsLayerClip)
    
    local medalsClip = cc.ClippingNode:create(medalsLayerClip)
    layerFallingMedals:addChild(medalsClip, 1)

    local stamp_apple_star = cc.Sprite:create("Images/Table/stamp_apple_star.png")
    stamp_apple_star:setPosition(visibleSize.width*.16, resolutionScaleY*visibleSize.height*1.1)
    medalsClip:addChild(stamp_apple_star)
    stamp_apple_star:setScale(.25)

    local stamp_chocolate_star = cc.Sprite:create("Images/Table/stamp_chocolate_star.png")
    stamp_chocolate_star:setPosition(visibleSize.width*.16, resolutionScaleY*visibleSize.height*1.1)
    medalsClip:addChild(stamp_chocolate_star)
    stamp_chocolate_star:setScale(.25)

    local stamp_egg_star = cc.Sprite:create("Images/Table/stamp_egg_star.png")
    stamp_egg_star:setPosition(visibleSize.width*.16, resolutionScaleY*visibleSize.height*1.1)
    medalsClip:addChild(stamp_egg_star)
    stamp_egg_star:setScale(.25)

    local stamp_milk_star = cc.Sprite:create("Images/Table/stamp_milk_star.png")
    stamp_milk_star:setPosition(visibleSize.width*.16, resolutionScaleY*visibleSize.height*1.1)
    medalsClip:addChild(stamp_milk_star)
    stamp_milk_star:setScale(.25)

    local stamp_strawberry_star = cc.Sprite:create("Images/Table/stamp_strawberry_star.png")
    stamp_strawberry_star:setPosition(visibleSize.width*.16, resolutionScaleY*visibleSize.height*1.1)
    medalsClip:addChild(stamp_strawberry_star)
    stamp_strawberry_star:setScale(.25)

    local stamp_wheat_star = cc.Sprite:create("Images/Table/stamp_wheat_star.png")
    stamp_wheat_star:setPosition(visibleSize.width*.16, resolutionScaleY*visibleSize.height*1.1)
    medalsClip:addChild(stamp_wheat_star)
    stamp_wheat_star:setScale(.25)

    layerFallingMedals:runAction(cc.Sequence:create(cc.DelayTime:create(0.3),cc.CallFunc:create(playEffectFallingMedalsCallback)))
    stamp_apple_star:runAction(cc.Sequence:create(cc.DelayTime:create(5.2), cc.Spawn:create(cc.RotateBy:create(1, -360), cc.MoveBy:create(1,cc.p(0,-resolutionScaleY*visibleSize.height*.5))),cc.CallFunc:create(deleteFallingMedalsCallback)))
    stamp_chocolate_star:runAction(cc.Sequence:create(cc.DelayTime:create(3.2), cc.Spawn:create(cc.RotateBy:create(1, -360), cc.MoveBy:create(1,cc.p(0,-resolutionScaleY*visibleSize.height*.5)))))
    stamp_egg_star:runAction(cc.Sequence:create(cc.DelayTime:create(1.2), cc.Spawn:create(cc.RotateBy:create(1, -360), cc.MoveBy:create(1,cc.p(0,-resolutionScaleY*visibleSize.height*.5)))))
    stamp_milk_star:runAction(cc.Sequence:create(cc.DelayTime:create(2.2), cc.Spawn:create(cc.RotateBy:create(1, -360), cc.MoveBy:create(1,cc.p(0,-resolutionScaleY*visibleSize.height*.5)))))
    stamp_strawberry_star:runAction(cc.Sequence:create(cc.DelayTime:create(4.2), cc.Spawn:create(cc.RotateBy:create(1, -360), cc.MoveBy:create(1,cc.p(0,-resolutionScaleY*visibleSize.height*.5)))))
    stamp_wheat_star:runAction(cc.Sequence:create(cc.DelayTime:create(0.2), cc.Spawn:create(cc.RotateBy:create(1, -360), cc.MoveBy:create(1,cc.p(0,-resolutionScaleY*visibleSize.height*.5)))))



    local function onTouchBegan(touch, event)
        return true
    end
    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
    listener:setSwallowTouches(true)
    local eventDispatcher = layerFallingMedals:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, layerFallingMedals)
    return layerFallingMedals
end

function createLayerCooking()
    local layerCooking = cc.Layer:create()

    local kitchen_back = cc.Sprite:create("Images/Cooking/kitchen_back.png")
    kitchen_back:setPosition(visibleSize.width * 0.5, visibleSize.height * 0.5)
    layerCooking:addChild(kitchen_back)

    local cake_machine = cc.Sprite:create("Images/Cooking/step_2/cake_machine.png")
    layerCooking:addChild(cake_machine)

    cake_machine:setPosition(visibleSize.width * 0.5, visibleSize.height * 0.45)
    cake_machine:setScale(1/resolutionScaleY)

    --cake_machine:setPosition(visibleSize.width * 0.5, 0)
    --cake_machine:setAnchorPoint(.5,.1)

    local transport = cc.Sprite:create("Images/Cooking/step_2/transport.png")
    transport:setPosition(visibleSize.width ,visibleSize.height * 0.215)
    cake_machine:addChild(transport,-1)

    local window = cc.Sprite:create("Images/Cooking/step_2/window.png")
    window:setPosition(cake_machine:getContentSize().width * 0.538, cake_machine:getContentSize().height* 0.358)
    cake_machine:addChild(window)

    local clipWindow = cc.ClippingNode:create(window)
    cake_machine:addChild(clipWindow)

    local stop_button = cc.Sprite:create("Images/Cooking/step_2/stop_button.png")
    stop_button:setPosition(cake_machine:getContentSize().width * 0.18, cake_machine:getContentSize().height* 0.25)
    cake_machine:addChild(stop_button)

    local start_button = cc.Sprite:create("Images/Cooking/step_2/start_button.png")
    start_button:setPosition(cake_machine:getContentSize().width * 0.18, cake_machine:getContentSize().height* 0.25)
    cake_machine:addChild(start_button)

    local animation_1 = cc.Sprite:create("Images/Cooking/step_2/animation_1.png")
    animation_1:setPosition(cake_machine:getContentSize().width * 0.75, cake_machine:getContentSize().height * 0.645)
    cake_machine:addChild(animation_1)

    local animation_21 = cc.Sprite:create("Images/Cooking/step_2/animation_1.png")
    animation_21:setPosition(cake_machine:getContentSize().width * 0.675, cake_machine:getContentSize().height * 0.645)
    cake_machine:addChild(animation_21)

    local animation_31 = cc.Sprite:create("Images/Cooking/step_2/animation_1.png")
    animation_31:setPosition(cake_machine:getContentSize().width * 0.6, cake_machine:getContentSize().height * 0.645)
    cake_machine:addChild(animation_31)

    local animation_2 = cc.Sprite:create("Images/Cooking/step_2/animation_2.png")
    animation_2:setPosition(cake_machine:getContentSize().width * 0.5, cake_machine:getContentSize().height * 0.645)
    cake_machine:addChild(animation_2)

    hand_2 = cc.LayerColor:create(cc.c4b(252, 210, 167,255),animation_2:getContentSize().width * 0.03, animation_2:getContentSize().height*.45)
    hand_2:setPosition(animation_2:getContentSize().width*.485, animation_2:getContentSize().height*.25)
    animation_2:addChild(hand_2)
    hand_2:setAnchorPoint(cc.p(.5,0))

    local animation_22 = cc.Sprite:create("Images/Cooking/step_2/animation_2.png")
    animation_22:setPosition(cake_machine:getContentSize().width * 0.37, cake_machine:getContentSize().height * 0.645)
    cake_machine:addChild(animation_22)

    hand_22 = cc.LayerColor:create(cc.c4b(252, 210, 167,255),animation_22:getContentSize().width * 0.03, animation_22:getContentSize().height*.45)
    hand_22:setPosition(animation_22:getContentSize().width*.485, animation_22:getContentSize().height*.25)
    animation_22:addChild(hand_22)
    hand_22:setAnchorPoint(cc.p(.5,0))

    local temperatureLayerClip = cc.LayerColor:create(cc.c4b(255,255,255,0),visibleSize.height*.2,cake_machine:getContentSize().height*.36)
    temperatureLayerClip:setPosition(visibleSize.width * 0.753, cake_machine:getContentSize().height*-.19)
    cake_machine:addChild(temperatureLayerClip)

    local temperatureClip = cc.ClippingNode:create(temperatureLayerClip)
    cake_machine:addChild(temperatureClip)

    local temperature_mask = cc.Sprite:create("Images/Cooking/step_2/temperature_mask.png")
    temperature_mask:setPosition(visibleSize.width * 0.503, cake_machine:getContentSize().height * 0.5)
    temperatureClip:addChild(temperature_mask)
    temperature_mask:setColor(cc.c3b(230, 25, 25))
    temperature_mask:setVisible(false)


--    local cookingCake = cc.Sprite:create("Images/Cooking/cakes/cake_" .. viewing .. ".png")
--    cookingCake:setPosition(visibleSize.width*.55,visibleSize.height*.345)
--    clipWindow:addChild(cookingCake)
--    cookingCake:setVisible(true)
--    cookingCake:setScale(.3)
--    cookingCake:getTexture()

    local cookedCake = cc.Sprite:create("Images/Cooking/cakes/cake_" .. viewing .. ".png")
    cookedCake:setPosition(visibleSize.width*.55,cake_machine:getContentSize().height*.375)
    clipWindow:addChild(cookedCake)
    cookedCake:setVisible(false)
    cookedCake:setScale(.3)

    if viewing == 1 or viewing == 5 or viewing == 6 or viewing == 8 or viewing == 10 then
        bad_cake_ref = cc.Sprite:create("Images/Cooking/cakes/bad_cake_1.png")
        bad_cake_ref:setPosition(cake_machine:getContentSize().width*.55,cake_machine:getContentSize().height*.375)
        clipWindow:addChild(bad_cake_ref)
        bad_cake_ref:setVisible(false)
    
        bad_cake_ref_no_fly = cc.Sprite:create("Images/Cooking/cakes/bad_cake_1_no_fly.png")
        bad_cake_ref_no_fly:setPosition(cake_machine:getContentSize().width*.55,cake_machine:getContentSize().height*.375)
        clipWindow:addChild(bad_cake_ref_no_fly)
        bad_cake_ref_no_fly:setVisible(false)
        bad_cake_ref_no_fly:setScale(.3)
    else
        bad_cake_ref = cc.Sprite:create("Images/Cooking/cakes/bad_cake_2.png")
        bad_cake_ref:setPosition(cake_machine:getContentSize().width*.55,cake_machine:getContentSize().height*.375)
        clipWindow:addChild(bad_cake_ref)
        bad_cake_ref:setVisible(false)
    
        bad_cake_ref_no_fly = cc.Sprite:create("Images/Cooking/cakes/bad_cake_2_no_fly.png")
        bad_cake_ref_no_fly:setPosition(cake_machine:getContentSize().width*.55,cake_machine:getContentSize().height*.375)
        clipWindow:addChild(bad_cake_ref_no_fly)
        bad_cake_ref_no_fly:setVisible(false)
        bad_cake_ref_no_fly:setScale(.3)
    end
    
    clockDisplayTimeSec = 20
    clockDisplayTimeMil = 0
    local  label = cc.Label:createWithTTF("20:00", "Fonts/Bariol_Regular.ttf", 150)
    label:setColor(cc.c3b(240,25,25))
    label:setPosition(cake_machine:getContentSize().width * 0.539, cake_machine:getContentSize().height * 0.85)
    cake_machine:addChild(label)

    cake_machine:addChild(createLayerFallingMedals())

    function cookingTimeOut()
        layerCooking:cleanup()
        cc.SimpleAudioEngine:getInstance():playEffect("Sounds/Effects/lose.mp3")
        bad_cake_ref:retain()
        bad_cake_ref:removeFromParent(false)
        partyBadScene = partyBadView(bad_cake_ref)
        cc.Director:getInstance():replaceScene( cc.TransitionFade:create(1, partyBadScene,cc.c3b(0,0,0)) )
    end
    function cookingClockTick()
        if clockDisplayTimeMil == 0 then
            if clockDisplayTimeSec == 0 then
                clockDisplayTimeSec=0
            else
                clockDisplayTimeSec=clockDisplayTimeSec-1
                clockDisplayTimeMil=9
            end
        else
            clockDisplayTimeMil=clockDisplayTimeMil-1
        end

        if clockDisplayTimeSec == 0 and clockDisplayTimeMil == 0 then
            miliseconds=0
        else
            miliseconds = math.random(10)-1
        end
        label:setString(string.format("%02d", clockDisplayTimeSec) .. ":" .. clockDisplayTimeMil .. miliseconds)

    end
    function startMachine()
        hand_2:runAction(cc.Repeat:create(cc.Sequence:create(cc.RotateBy:create(.3,-40), cc.RotateBy:create(.4,80),cc.RotateBy:create(.3,-40)),20))
        hand_22:runAction(cc.Repeat:create(cc.Sequence:create(cc.RotateBy:create(.6,-40), cc.RotateBy:create(.8,80),cc.RotateBy:create(.6,-40)),10))
        animation_1:runAction(cc.Repeat:create(cc.Sequence:create(cc.RotateBy:create(.3,-30), cc.RotateBy:create(.4,60),cc.RotateBy:create(.3,-30)),20))
        animation_21:runAction(cc.Repeat:create(cc.Sequence:create(cc.RotateBy:create(.6,-30), cc.RotateBy:create(.8,60),cc.RotateBy:create(.6,-30)),10))
        animation_31:runAction(cc.Repeat:create(cc.Sequence:create(cc.RotateBy:create(3,-360), cc.RotateBy:create(5,360),cc.RotateBy:create(2,-30)),2))
        temperature_mask:runAction(cc.Repeat:create(cc.Sequence:create(cc.TintTo:create(.333,25, 230, 25), cc.TintTo:create(.333,230, 25, 25)),30))
        temperature_mask:setVisible(true)
        temperature_mask:setOpacity(170)
        local barSize = temperatureLayerClip:getContentSize().height
        temperatureLayerClip:runAction(cc.Repeat:create(cc.Sequence:create(cc.MoveBy:create(.333,cc.p(0, barSize)), cc.MoveBy:create(.333,cc.p(0, -barSize))),30))
        cookedCake:runAction(cc.Repeat:create(cc.Sequence:create(cc.FadeIn:create(.333), cc.FadeOut:create(.333)),30))
        cookedCake:setVisible(true)
        bad_cake_ref_no_fly:runAction(cc.Repeat:create(cc.Sequence:create(cc.FadeOut:create(.333), cc.FadeIn:create(.333)),30))
        bad_cake_ref_no_fly:setVisible(true)

        label:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(.1), cc.CallFunc:create(cookingClockTick))))
        label:runAction(cc.Sequence:create(cc.DelayTime:create(20.1), cc.CallFunc:create(cookingTimeOut)))
    end


    local function onTouchBegan(touch, event)
        local location = cake_machine:convertToNodeSpace(touch:getLocation())

        local rect_start_button = start_button:getBoundingBox()
        if cc.rectContainsPoint(rect_start_button, location) then
            start_button_tinted = true
            start_button:setColor(cc.c3b(91, 199, 215))
        end
        if cc.rectContainsPoint(rect_start_button, location) and not start_button:isVisible() then
            start_button_tinted = true
            stop_button:setColor(cc.c3b(91, 199, 215))
        end
        -- CCTOUCHBEGAN event must return true
        return true
    end
    local function onTouchMoved(touch, event)
        local location = cake_machine:convertToNodeSpace(touch:getLocation())

        local rect_start_button = start_button:getBoundingBox()
        if not cc.rectContainsPoint(rect_start_button, location) and start_button_tinted then
            start_button_tinted = false
            start_button:setColor(cc.c3b(255, 255, 255))
        end
        if not cc.rectContainsPoint(rect_start_button, location) and not start_button:isVisible() and start_button_tinted then
            start_button_tinted = false
            stop_button:setColor(cc.c3b(255, 255, 255))
        end
    end
        -- handing touch events
    local function onTouchEnded(touch, event)
        local location = cake_machine:convertToNodeSpace(touch:getLocation())

        local rect_start_button = start_button:getBoundingBox()
        if cc.rectContainsPoint(rect_start_button, location) and start_button_tinted then
            start_button_tinted = false
            start_button:setColor(cc.c3b(255, 255, 255))
            cc.SimpleAudioEngine:getInstance():playEffect("Sounds/Effects/click.mp3")
            if start_button:isVisible() then
                start_button:setVisible(false)
                startMachine()
            else
                start_button_tinted = false
                stop_button:setColor(cc.c3b(255, 255, 255))
                layerCooking:cleanup()
                if temperatureLayerClip:getPositionY()>visibleSize.height*.15-temperatureLayerClip:getContentSize().height*.5 then
                    cookingPassed = true
                end
                if cookingPassed then
                    cc.SimpleAudioEngine:getInstance():playEffect("Sounds/Effects/win.mp3")
                    cc.Director:getInstance():replaceScene( cc.TransitionFade:create(1, decoratingView(),cc.c3b(0,0,0)) )
                else
                    cc.SimpleAudioEngine:getInstance():playEffect("Sounds/Effects/lose.mp3")
                    bad_cake_ref:retain()
                    bad_cake_ref:removeFromParent(false)
                    partyBadScene = partyBadView(bad_cake_ref)
                    cc.Director:getInstance():replaceScene( cc.TransitionFade:create(1, partyBadScene,cc.c3b(0,0,0)) )
                end
            end
        end

        
    end

    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
    listener:registerScriptHandler(onTouchMoved,cc.Handler.EVENT_TOUCH_MOVED )
    listener:registerScriptHandler(onTouchEnded,cc.Handler.EVENT_TOUCH_ENDED )
    local eventDispatcher = layerCooking:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, layerCooking)

    return layerCooking
end

function createLayerDecorating()
    local layerDecorating = cc.Layer:create()

    local kitchen_back = cc.Sprite:create("Images/Cooking/kitchen_back.png")
    kitchen_back:setPosition(visibleSize.width * 0.5, visibleSize.height * 0.5)
    layerDecorating:addChild(kitchen_back)

    local transport_long = cc.Sprite:create("Images/Cooking/step_3/transport_long.png")
    transport_long:setPosition(transport_long:getContentSize().width*.5, visibleSize.height * 0.07)
    layerDecorating:addChild(transport_long)
    transport_long:setAnchorPoint(.5,1)

    local transport_long1 = cc.Sprite:create("Images/Cooking/step_3/transport_long.png")
    transport_long1:setPosition(transport_long:getContentSize().width*1.5, visibleSize.height * 0.07)
    layerDecorating:addChild(transport_long1)
    transport_long1:setAnchorPoint(.5,1)

    local selector_back = cc.Sprite:create("Images/Cooking/step_3/selector_back.png")
    selector_back:setPosition(selector_back:getContentSize().width * 0.6, 0)
    selector_back:setAnchorPoint(.5,0)
    layerDecorating:addChild(selector_back)

    local selector_arrow_up = cc.Sprite:create("Images/Cooking/step_3/selector_arrow.png")
    selector_arrow_up:setPosition(selector_back:getContentSize().width * 0.48, visibleSize.height-selector_arrow_up:getContentSize().height*.5)
    selector_back:addChild(selector_arrow_up)

    local selector_arrow_down = cc.Sprite:create("Images/Cooking/step_3/selector_arrow.png")
    selector_arrow_down:setPosition(selector_back:getContentSize().width * 0.48, selector_arrow_down:getContentSize().height*.5)
    selector_back:addChild(selector_arrow_down)
    selector_arrow_down:setFlippedY(true)
    selector_arrow_down:setVisible(false)

    referenceCake = cc.Sprite:create("Images/Cooking/cakes/cake_" .. viewing .. ".png")
    referenceCake:setPosition(visibleSize.width * .65, visibleSize.height * 0.07)
    layerDecorating:addChild(referenceCake)
    referenceCake:setAnchorPoint(.5,0)
    referenceCake:setScale(1/resolutionScaleY)


    local cake_decoration_1 = cc.Sprite:create("Images/Cooking/step_3/cake_decoration_1.png")
    cake_decoration_1:setPosition(referenceCake:getContentSize().width * 0.5, referenceCake:getContentSize().height * .6)
    referenceCake:addChild(cake_decoration_1)

    local cake_decoration_2 = cc.Sprite:create("Images/Cooking/step_3/cake_decoration_2.png")
    cake_decoration_2:setPosition(referenceCake:getContentSize().width * 0.5, referenceCake:getContentSize().height * .6)
    referenceCake:addChild(cake_decoration_2)

    local cake_decoration_3 = cc.Sprite:create("Images/Cooking/step_3/cake_decoration_3.png")
    cake_decoration_3:setPosition(referenceCake:getContentSize().width * 0.5, referenceCake:getContentSize().height * .6)
    referenceCake:addChild(cake_decoration_3)

    local cake_decoration_4 = cc.Sprite:create("Images/Cooking/step_3/cake_decoration_4.png")
    cake_decoration_4:setPosition(referenceCake:getContentSize().width * 0.5, referenceCake:getContentSize().height * .6)
    referenceCake:addChild(cake_decoration_4,-1)

    local cake_decoration_5 = cc.Sprite:create("Images/Cooking/step_3/cake_decoration_5.png")
    cake_decoration_5:setPosition(referenceCake:getContentSize().width * 0.5, referenceCake:getContentSize().height * .6)
    referenceCake:addChild(cake_decoration_5,-2)

    local cake_decoration_6 = cc.Sprite:create("Images/Cooking/step_3/cake_decoration_6.png")
    cake_decoration_6:setPosition(referenceCake:getContentSize().width * 0.5, referenceCake:getContentSize().height * .6)
    referenceCake:addChild(cake_decoration_6,-3)


    cake_decoration_1:setVisible(false)
    cake_decoration_2:setVisible(false)
    cake_decoration_3:setVisible(false)
    cake_decoration_4:setVisible(false)
    cake_decoration_5:setVisible(false)
    cake_decoration_6:setVisible(false)


    local upper_go_button = cc.Sprite:create("Images/Cooking/step_3/upper_go_button.png")
    upper_go_button:setPosition(visibleSize.width-upper_go_button:getContentSize().width, visibleSize.height-upper_go_button:getContentSize().height*.5)
    layerDecorating:addChild(upper_go_button)

    local layerDecorations = cc.LayerColor:create(cc.c4b(255,255,255,0),selector_back:getContentSize().width,visibleSize.height*2)
    selector_back:addChild(layerDecorations)

    local decoration_1 = cc.Sprite:create("Images/Cooking/step_3/decoration_1.png")
    decoration_1:setPosition(selector_back:getContentSize().width * 0.5, visibleSize.height * 0.25)
    layerDecorations:addChild(decoration_1)

    local decoration_2 = cc.Sprite:create("Images/Cooking/step_3/decoration_2.png")
    decoration_2:setPosition(selector_back:getContentSize().width * 0.5, visibleSize.height * 0.5)
    layerDecorations:addChild(decoration_2)

    local decoration_3 = cc.Sprite:create("Images/Cooking/step_3/decoration_3.png")
    decoration_3:setPosition(selector_back:getContentSize().width * 0.5, visibleSize.height * 0.75)
    layerDecorations:addChild(decoration_3)

    local decoration_4 = cc.Sprite:create("Images/Cooking/step_3/decoration_4.png")
    decoration_4:setPosition(selector_back:getContentSize().width * 0.5, visibleSize.height * 1.25)
    layerDecorations:addChild(decoration_4)

    local decoration_5 = cc.Sprite:create("Images/Cooking/step_3/decoration_5.png")
    decoration_5:setPosition(selector_back:getContentSize().width * 0.5, visibleSize.height * 1.5)
    layerDecorations:addChild(decoration_5)

    local decoration_6 = cc.Sprite:create("Images/Cooking/step_3/decoration_6.png")
    decoration_6:setPosition(selector_back:getContentSize().width * 0.5, visibleSize.height * 1.75)
    layerDecorations:addChild(decoration_6)

    local function onTouchBegan(touch, event)
        local location = touch:getLocation()
        local rect_upper_go_button = upper_go_button:getBoundingBox()
        if cc.rectContainsPoint(rect_upper_go_button, location) then
            upper_go_button_tinted = true
            upper_go_button:setColor(cc.c3b(91, 199, 215))
        end

        local rect_selector_arrow_up = selector_arrow_up:getBoundingBox()
        if cc.rectContainsPoint(rect_selector_arrow_up, location) and selector_arrow_up:isVisible() then
            selector_arrow_up_tinted = true
            selector_arrow_up:setColor(cc.c3b(91, 199, 215))
        end

        local rect_selector_arrow_down = selector_arrow_down:getBoundingBox()
        if cc.rectContainsPoint(rect_selector_arrow_down, location) and selector_arrow_down:isVisible() then
            selector_arrow_down_tinted = true
            selector_arrow_down:setColor(cc.c3b(91, 199, 215))
        end

        local rect_decoration_1 = decoration_1:getBoundingBox()
        if cc.rectContainsPoint(rect_decoration_1, location) and selector_arrow_up:isVisible() then
            decoration_1_tinted = true
            decoration_1:setColor(cc.c3b(91, 199, 215))
        end

        local rect_decoration_2 = decoration_2:getBoundingBox()
        if cc.rectContainsPoint(rect_decoration_2, location) and selector_arrow_up:isVisible() then
            decoration_2_tinted = true
            decoration_2:setColor(cc.c3b(91, 199, 215))
        end

        local rect_decoration_3 = decoration_3:getBoundingBox()
        if cc.rectContainsPoint(rect_decoration_3, location) and selector_arrow_up:isVisible() then
            decoration_3_tinted = true
            decoration_3:setColor(cc.c3b(91, 199, 215))
        end

        if cc.rectContainsPoint(rect_decoration_1, location) and selector_arrow_down:isVisible() then
            decoration_4_tinted = true
            decoration_4:setColor(cc.c3b(91, 199, 215))
        end

        if cc.rectContainsPoint(rect_decoration_2, location) and selector_arrow_down:isVisible() then
            decoration_5_tinted = true
            decoration_5:setColor(cc.c3b(91, 199, 215))
        end

        if cc.rectContainsPoint(rect_decoration_3, location) and selector_arrow_down:isVisible() then
            decoration_6_tinted = true
            decoration_6:setColor(cc.c3b(91, 199, 215))
        end
        return true
    end

    local function onTouchMoved(touch, event)
        local location = touch:getLocation()
        local rect_upper_go_button = upper_go_button:getBoundingBox()
        if not cc.rectContainsPoint(rect_upper_go_button, location) and upper_go_button_tinted then
            upper_go_button_tinted = false
            upper_go_button:setColor(cc.c3b(255,255,255))
        end

        local rect_selector_arrow_up = selector_arrow_up:getBoundingBox()
        if not cc.rectContainsPoint(rect_selector_arrow_up, location) and selector_arrow_up:isVisible() and selector_arrow_up_tinted then
            selector_arrow_up_tinted = false
            selector_arrow_up:setColor(cc.c3b(255,255,255))
        end

        local rect_selector_arrow_down = selector_arrow_down:getBoundingBox()
        if not cc.rectContainsPoint(rect_selector_arrow_down, location) and selector_arrow_down:isVisible() and selector_arrow_down_tinted then
            selector_arrow_down_tinted = false
            selector_arrow_down:setColor(cc.c3b(255,255,255))
        end

        local rect_decoration_1 = decoration_1:getBoundingBox()
        if not cc.rectContainsPoint(rect_decoration_1, location) and selector_arrow_up:isVisible() and decoration_1_tinted then
            decoration_1_tinted = false
            decoration_1:setColor(cc.c3b(255,255,255))
        end

        local rect_decoration_2 = decoration_2:getBoundingBox()
        if not cc.rectContainsPoint(rect_decoration_2, location) and selector_arrow_up:isVisible() and decoration_2_tinted then
            decoration_2_tinted = false
            decoration_2:setColor(cc.c3b(255,255,255))
        end

        local rect_decoration_3 = decoration_3:getBoundingBox()
        if not cc.rectContainsPoint(rect_decoration_3, location) and selector_arrow_up:isVisible() and decoration_3_tinted then
            decoration_3_tinted = false
            decoration_3:setColor(cc.c3b(255,255,255))
        end

        if not cc.rectContainsPoint(rect_decoration_1, location) and selector_arrow_down:isVisible() and decoration_4_tinted then
            decoration_4_tinted = false
            decoration_4:setColor(cc.c3b(255,255,255))
        end

        if not cc.rectContainsPoint(rect_decoration_2, location) and selector_arrow_down:isVisible() and decoration_5_tinted then
            decoration_5_tinted = false
            decoration_5:setColor(cc.c3b(255,255,255))
        end

        if not cc.rectContainsPoint(rect_decoration_3, location) and selector_arrow_down:isVisible() and decoration_6_tinted then
            decoration_6_tinted = false
            decoration_6:setColor(cc.c3b(255,255,255))
        end
        
    end
        -- handing touch events
    local function onTouchEnded(touch, event)
        local location = touch:getLocation()
        local rect_upper_go_button = upper_go_button:getBoundingBox()

        if cc.rectContainsPoint(rect_upper_go_button, location) and upper_go_button_tinted then
            upper_go_button_tinted = false
            upper_go_button:setColor(cc.c3b(255,255,255))
            cc.SimpleAudioEngine:getInstance():playEffect("Sounds/Effects/click.mp3")
            referenceCake:retain()
            referenceCake:removeFromParent(false)
            partyGoodScene = partyGoodView(referenceCake)
            cc.Director:getInstance():replaceScene( cc.TransitionFade:create(1, partyGoodScene, cc.c3b(0,0,0)) )
        end

        local rect_selector_arrow_up = selector_arrow_up:getBoundingBox()
        if cc.rectContainsPoint(rect_selector_arrow_up, location) and selector_arrow_up:isVisible() and selector_arrow_up_tinted then
            selector_arrow_up_tinted = false
            selector_arrow_up:setColor(cc.c3b(255,255,255))
            selector_arrow_down:setVisible(true)
            selector_arrow_up:setVisible(false)
            layerDecorations:runAction(cc.EaseInOut:create(cc.MoveBy:create(1, cc.p(0, -visibleSize.height)), 2))
        end

        local rect_selector_arrow_down = selector_arrow_down:getBoundingBox()
        if cc.rectContainsPoint(rect_selector_arrow_down, location) and selector_arrow_down:isVisible() and selector_arrow_down_tinted then
            selector_arrow_down_tinted = false
            selector_arrow_down:setColor(cc.c3b(255,255,255))
            selector_arrow_down:setVisible(false)
            selector_arrow_up:setVisible(true)
            layerDecorations:runAction(cc.EaseInOut:create(cc.MoveBy:create(1, cc.p(0, visibleSize.height)), 2))
        end

        local rect_decoration_1 = decoration_1:getBoundingBox()
        if cc.rectContainsPoint(rect_decoration_1, location) and selector_arrow_up:isVisible() and decoration_1_tinted then
            decoration_1_tinted = false
            decoration_1:setColor(cc.c3b(255,255,255))
            cake_decoration_1:setVisible(not cake_decoration_1:isVisible())
        end

        local rect_decoration_2 = decoration_2:getBoundingBox()
        if cc.rectContainsPoint(rect_decoration_2, location) and selector_arrow_up:isVisible() and decoration_2_tinted then
            decoration_2_tinted = false
            decoration_2:setColor(cc.c3b(255,255,255))
            cake_decoration_2:setVisible(not cake_decoration_2:isVisible())
        end

        local rect_decoration_3 = decoration_3:getBoundingBox()
        if cc.rectContainsPoint(rect_decoration_3, location) and selector_arrow_up:isVisible() and decoration_3_tinted then
            decoration_3_tinted = false
            decoration_3:setColor(cc.c3b(255,255,255))
            cake_decoration_3:setVisible(not cake_decoration_3:isVisible())
        end

        if cc.rectContainsPoint(rect_decoration_1, location) and selector_arrow_down:isVisible() and decoration_4_tinted then
            decoration_4_tinted = false
            decoration_4:setColor(cc.c3b(255,255,255))
            cake_decoration_4:setVisible(not cake_decoration_4:isVisible())
        end

        if cc.rectContainsPoint(rect_decoration_2, location) and selector_arrow_down:isVisible() and decoration_5_tinted then
            decoration_5_tinted = false
            decoration_5:setColor(cc.c3b(255,255,255))
            cake_decoration_5:setVisible(not cake_decoration_5:isVisible())
        end

        if cc.rectContainsPoint(rect_decoration_3, location) and selector_arrow_down:isVisible() and decoration_6_tinted then
            decoration_6_tinted = false
            decoration_6:setColor(cc.c3b(255,255,255))
            cake_decoration_6:setVisible(not cake_decoration_6:isVisible())
        end
    end

    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
    listener:registerScriptHandler(onTouchMoved,cc.Handler.EVENT_TOUCH_MOVED )
    listener:registerScriptHandler(onTouchEnded,cc.Handler.EVENT_TOUCH_ENDED )
    local eventDispatcher = layerDecorating:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, layerDecorating)


    return layerDecorating
end

