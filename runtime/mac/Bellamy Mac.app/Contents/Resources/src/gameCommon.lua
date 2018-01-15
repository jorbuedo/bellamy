function goToCookingCallback()
    cc.SimpleAudioEngine:getInstance():preloadEffect("Sounds/Effects/final_part/medals.mp3")
    --cc.SimpleAudioEngine:getInstance():preloadMusic("Sounds/Music/Final.mp3")
    --cc.SimpleAudioEngine:getInstance():preloadMusic("Sounds/Music/Final_bad.mp3")
    local cake_1 = cc.Sprite:create("Images/Cooking/cakes/cake_1.png")
    local cake_10 = cc.Sprite:create("Images/Cooking/cakes/cake_10.png")
    local cake_11 = cc.Sprite:create("Images/Cooking/cakes/cake_11.png")
    local cake_2 = cc.Sprite:create("Images/Cooking/cakes/cake_2.png")
    local cake_3 = cc.Sprite:create("Images/Cooking/cakes/cake_3.png")
    local cake_4 = cc.Sprite:create("Images/Cooking/cakes/cake_4.png")
    local cake_5 = cc.Sprite:create("Images/Cooking/cakes/cake_5.png")
    local cake_6 = cc.Sprite:create("Images/Cooking/cakes/cake_6.png")
    local cake_7 = cc.Sprite:create("Images/Cooking/cakes/cake_7.png")
    local cake_8 = cc.Sprite:create("Images/Cooking/cakes/cake_8.png")
    local cake_9 = cc.Sprite:create("Images/Cooking/cakes/cake_9.png")
    local kitchen_back = cc.Sprite:create("Images/Cooking/kitchen_back.png")
    local kitchen_full_back = cc.Sprite:create("Images/Cooking/kitchen_full_back.png")
    local go_button = cc.Sprite:create("Images/Cooking/step_1/go_button.png")
    local go_loading_button = cc.Sprite:create("Images/Cooking/step_1/go_loading_button.png")
    local kitchen_full_back = cc.Sprite:create("Images/Cooking/step_1/kitchen_full_back.png")
    local select_button = cc.Sprite:create("Images/Cooking/step_1/select_button.png")
    local selector_front = cc.Sprite:create("Images/Cooking/step_1/selector_front.png")
    local selector_machine = cc.Sprite:create("Images/Cooking/step_1/selector_machine.png")
    cc.Director:getInstance():replaceScene( cc.TransitionFade:create(1, selectCakeView(), cc.c3b(0,0,0)))
end
function createLayerConfetti()
    layerConfetti = cc.Layer:create()
    layerConfetti:setPosition(0, visibleSize.height)
    layerConfetti:runAction(cc.MoveBy:create(6, cc.p(0,-visibleSize.height)))


    for i=1,150 do
        if i%2 == 0 then
            confetti = cc.Sprite:create("Generators/confetti-01.png")
        else
            confetti = cc.Sprite:create("Generators/confetti-02.png")
        end
        confetti:setPosition(visibleSize.width*.01*math.random(100), visibleSize.height*.01*math.random(100))
        confetti:setScale(.15*math.random(3))
        layerConfetti:addChild(confetti)
        setConfettiColor = {
        [1] = function() confetti:setColor(cc.c3b(230,25,25)) end,
        [2] = function() confetti:setColor(cc.c3b(25,230,25)) end,
        [3] = function() confetti:setColor(cc.c3b(25,25,230)) end,
        [4] = function() confetti:setColor(cc.c3b(230,230,25)) end,
        [5] = function() confetti:setColor(cc.c3b(230,25,230)) end,
        [6] = function() confetti:setColor(cc.c3b(25,230,230)) end,
        }
        setConfettiColor[math.random(6)]()
    end

    return layerConfetti
end
function allGamesFinished()
    mapScene:addChild(createLayerConfetti())
    mapScene:addChild(createLayerTable(true))
    mapScene:runAction(cc.Sequence:create(cc.DelayTime:create(5), cc.CallFunc:create(goToCookingCallback)))
    cc.SimpleAudioEngine:getInstance():stopMusic(true)
    cc.SimpleAudioEngine:getInstance():playMusic("Sounds/Music/Final.mp3", true)
end

function moveToken(points)
    if points < 0 then
        points = 0
    elseif points > 100 then
        points = 100
    end
    gameToken:runAction(cc.Spawn:create(cc.MoveTo:create(.3, cc.p(layerLeftBar:getContentSize().width*.5, visibleSize.height*.5+points*.01*.42*visibleSize.height)), cc.Sequence:create(cc.RotateBy:create(.1, 40),cc.RotateTo:create(.1, 0))))
    return points
end


function createLayerLeft(startGame, token)
    local back = cc.Sprite:create("Images/Common/back.png")

    layerLeftBar = cc.LayerColor:create(cc.c4b(254,206,6,255), visibleSize.width*.15, visibleSize.height)
    layerLeftBar:setPosition(0, 0)

    back:setPosition(layerLeftBar:getContentSize().width * 0.5, visibleSize.height*.15)
    layerLeftBar:addChild(back)
    local play_again = cc.Sprite:create("Images/Common/play_again.png")
    play_again:setPosition(layerLeftBar:getContentSize().width * 0.5, visibleSize.height*.33)
    layerLeftBar:addChild(play_again)

    if token then
        local score_bar = cc.LayerColor:create(cc.c4b(215, 190, 91,255),layerLeftBar:getContentSize().width * 0.1,visibleSize.height*.42)
        score_bar:setPosition(layerLeftBar:getContentSize().width * 0.45, visibleSize.height*.5)
        layerLeftBar:addChild(score_bar)
        local circle1 = cc.Sprite:create("Generators/confetti-02.png")
        circle1:setColor(cc.c3b(215, 190, 91))
        score_bar:addChild(circle1)
        circle1:setPosition(score_bar:getContentSize().width*.5, score_bar:getContentSize().height*1)
        circle1:setScale(.118)
        local circle2 = cc.Sprite:create("Generators/confetti-02.png")
        circle2:setColor(cc.c3b(215, 190, 91))
        score_bar:addChild(circle2)
        circle2:setPosition(score_bar:getContentSize().width*.5, score_bar:getContentSize().height*0)
        circle2:setScale(.118)
    
        gameToken = cc.Sprite:create(token)
        --gameToken:setTag(666)
        layerLeftBar:addChild(gameToken, 100)
        gameToken:setPosition(layerLeftBar:getContentSize().width*.5, visibleSize.height*.5)
        
        local scoreLayerClip = cc.LayerColor:create(cc.c4b(255,255,255,0),visibleSize.width*.5 ,visibleSize.height*.53)
        scoreLayerClip:setPosition(-layerLeftBar:getContentSize().width*.27, -visibleSize.height*.47)
        gameToken:addChild(scoreLayerClip)
        
        local scoreClip = cc.ClippingNode:create(scoreLayerClip)
        layerLeftBar:addChild(scoreClip, 1)
    
        local score_mask = cc.LayerColor:create(cc.c4b(25,220,25,255),layerLeftBar:getContentSize().width*.11 ,visibleSize.height*.42)
        score_mask:setPosition(layerLeftBar:getContentSize().width * 0.45, visibleSize.height*.5)
        scoreClip:addChild(score_mask)
        local circle1 = cc.Sprite:create("Generators/confetti-02.png")
        circle1:setColor(cc.c3b(25,220,25))
        score_mask:addChild(circle1)
        circle1:setPosition(score_mask:getContentSize().width*.5, score_mask:getContentSize().height*1)
        circle1:setScale(.118)
        local circle2 = cc.Sprite:create("Generators/confetti-02.png")
        circle2:setColor(cc.c3b(25,220,25))
        score_mask:addChild(circle2)
        circle2:setPosition(score_mask:getContentSize().width*.5, score_mask:getContentSize().height*0)
        circle2:setScale(.118)
    end

    local function deleteOverCallback()
        layerOver:removeFromParent(true)
    end
    local function onTouchBegan(touch, event)
        local location = touch:getLocation()
        local rectBack = back:getBoundingBox()
        local rectAgain = play_again:getBoundingBox()

        if cc.rectContainsPoint(rectBack, location) then
            cc.SimpleAudioEngine:getInstance():playEffect("Sounds/Effects/click.mp3")
            cc.SimpleAudioEngine:getInstance():stopMusic(true)
            cc.SimpleAudioEngine:getInstance():playMusic("Sounds/Music/MainMusic.mp3", true)
            cc.Director:getInstance():popScene()
            unique = true
            layerOverDown=nil
        end
        if cc.rectContainsPoint(rectAgain, location) then
            cc.SimpleAudioEngine:getInstance():playEffect("Sounds/Effects/click.mp3")
            layerLeftBar:getParent():cleanup()
            if layerOverDown then
                layerOverDown=nil
                layerOver:runAction(cc.Sequence:create(cc.MoveBy:create(.8, cc.p(0,visibleSize.height)), cc.CallFunc:create(deleteOverCallback)))
            end
            moveToken(0)
            layerGame.restartGame()
            layerLeftBar:getParent():addChild(countDown(startGame))
        end
        return true
    end

    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
    local eventDispatcher = layerLeftBar:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, layerLeftBar)

    return layerLeftBar
end

function startClock(timeout)
    circleClock:setColor(cc.c3b(254,206,6))
    hand:runAction(cc.Sequence:create(cc.RotateTo:create(0, 0),cc.RotateBy:create(timeout, 360)))
    circleClock:runAction(cc.Sequence:create(cc.TintTo:create(0, 254,206,6),cc.DelayTime:create(timeout*.75),cc.TintTo:create(.5, 220,25,25)))
    --timeout()
end

function createLayerClock()
    local layerClock = cc.Layer:create()
    local clock = cc.Sprite:create("Images/Common/clock.png")
    layerClock:addChild(clock)
    clock:setPosition(visibleSize.width-clock:getContentSize().width*.5, visibleSize.height-clock:getContentSize().height*.5)
    circleClock = cc.Sprite:create("Generators/confetti-02.png")
    circleClock:setColor(cc.c3b(254,206,6))
    clock:addChild(circleClock)
    circleClock:setPosition(clock:getContentSize().width*.488, clock:getContentSize().height*.436)
    circleClock:setScale(.66)

    hand = cc.LayerColor:create(cc.c4b(103, 61, 27,255),circleClock:getContentSize().width * 0.08, circleClock:getContentSize().height*.35)
    hand:setPosition(clock:getContentSize().width*.5, clock:getContentSize().height*.5)
    circleClock:addChild(hand)
    hand:setAnchorPoint(cc.p(.5,0))

    local circle1 = cc.Sprite:create("Generators/confetti-02.png")
    circle1:setColor(cc.c3b(103, 61, 27))
    hand:addChild(circle1)
    circle1:setPosition(hand:getContentSize().width*.5, hand:getContentSize().height)
    circle1:setScale(.085)
    local circle2 = cc.Sprite:create("Generators/confetti-02.png")
    circle2:setColor(cc.c3b(103, 61, 27))
    hand:addChild(circle2)
    circle2:setPosition(hand:getContentSize().width*.5, 0)
    circle2:setScale(.085)
    return layerClock
end

function createLayerGameWin(gameWin)
    local function popSceneCallback()
        unique = true
        cc.SimpleAudioEngine:getInstance():stopMusic(true)
        cc.SimpleAudioEngine:getInstance():playMusic("Sounds/Music/MainMusic.mp3", true)
        cc.Director:getInstance():popScene()

        if stamp_apple_star_won and stamp_chocolate_star_won and stamp_egg_star_won and stamp_milk_star_won and stamp_strawberry_star_won and stamp_wheat_star_won then
            allGamesFinished()
        end
    end

    cc.SimpleAudioEngine:getInstance():stopMusic(true)
    cc.SimpleAudioEngine:getInstance():playEffect("Sounds/Effects/win.mp3")
    local layerWin = createLayerTable(true)

    local table = layerWin:getChildByTag(213)

    local winStamp = {
        ["Apple"] = function() stamp_apple_star_won=true;cc.UserDefault:getInstance():setBoolForKey("stamp_apple_star_won",true);stamp_star_win = cc.Sprite:create("Images/Table/stamp_apple_star.png"); stamp_star_win_width = table:getContentSize().width*.765;stamp_star_win_height =  table:getContentSize().height*.265; end,
        ["Chocolate"] = function() stamp_chocolate_star_won=true;cc.UserDefault:getInstance():setBoolForKey("stamp_chocolate_star_won",true); stamp_star_win = cc.Sprite:create("Images/Table/stamp_chocolate_star.png"); stamp_star_win_width = table:getContentSize().width*.265;stamp_star_win_height =  table:getContentSize().height*.57;end,
        ["Egg"] = function() stamp_egg_star_won=true;cc.UserDefault:getInstance():setBoolForKey("stamp_egg_star_won",true); stamp_star_win = cc.Sprite:create("Images/Table/stamp_egg_star.png"); stamp_star_win_width = table:getContentSize().width*.265;stamp_star_win_height =  table:getContentSize().height*.265;end,
        ["Milk"] = function() stamp_milk_star_won=true;cc.UserDefault:getInstance():setBoolForKey("stamp_milk_star_won",true); stamp_star_win = cc.Sprite:create("Images/Table/stamp_milk_star.png"); stamp_star_win_width = table:getContentSize().width*.52;stamp_star_win_height =  table:getContentSize().height*.265;end,
        ["Strawberry"] = function() stamp_strawberry_star_won=true;cc.UserDefault:getInstance():setBoolForKey("stamp_strawberry_star_won",true); stamp_star_win = cc.Sprite:create("Images/Table/stamp_strawberry_star.png"); stamp_star_win_width = table:getContentSize().width*.765;stamp_star_win_height =  table:getContentSize().height*.57;end,
        ["Wheat"] = function() stamp_wheat_star_won=true;cc.UserDefault:getInstance():setBoolForKey("stamp_wheat_star_won",true); stamp_star_win = cc.Sprite:create("Images/Table/stamp_wheat_star.png"); stamp_star_win_width = table:getContentSize().width*.52;stamp_star_win_height =  table:getContentSize().height*.57;end
    }

    winStamp[gameWin]()
    table:addChild(stamp_star_win)
    stamp_star_win:setPosition(visibleSize.width*.35, resolutionScaleY* visibleSize.height*.35)
    stamp_star_win:runAction(cc.Sequence:create(cc.DelayTime:create(2),cc.MoveTo:create(1.5, cc.p(stamp_star_win_width, stamp_star_win_height))))
    stamp_star_win:runAction(cc.Sequence:create(cc.ScaleTo:create(0, .1),cc.ScaleTo:create(1.5, 1),cc.DelayTime:create(.5),cc.ScaleTo:create(1.5, .35)))
    stamp_star_win:runAction(cc.Sequence:create(cc.RotateBy:create(1.5, 360),cc.DelayTime:create(.5),cc.RotateBy:create(1.5, 360),cc.DelayTime:create(.5), cc.CallFunc:create(popSceneCallback)))

    return layerWin
end

function createLayerGameOver(gameOver)
    layerOverDown=true
    layerOver = cc.LayerColor:create(cc.c4b(50, 50, 50, 200), visibleSize.width*.85, visibleSize.height)
    layerOver:setPosition(visibleSize.width*.15, visibleSize.height)
    layerOver:addChild(gameOver)
    gameOver:setPosition(layerOver:getContentSize().width*.5, visibleSize.height*.5)
    layerOver:runAction(cc.Sequence:create(cc.DelayTime:create(1), cc.MoveBy:create(.8, cc.p(0, -visibleSize.height*1))))
    cc.SimpleAudioEngine:getInstance():playEffect("Sounds/Effects/lose.mp3")

        -- handing touch events
    local function onTouchBegan(touch, event)

        -- CCTOUCHBEGAN event must return true
        return true
    end

    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN )

    local eventDispatcher = layerOver:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, layerOver)

    return layerOver
end

function createLayerInfoWood(table, startGame)
    local layerTable = cc.Layer:create()
    layerTable:setPosition(0, visibleSize.height-table:getContentSize().height*.4)
    table:setPosition(visibleSize.width*.5, visibleSize.height)
    layerTable:addChild(table)
    local infoIsDown = false
    local function playEffectDown()
        if infoIsDown then
            cc.SimpleAudioEngine:getInstance():playEffect("Sounds/Effects/info_up.mp3")
        else
            cc.SimpleAudioEngine:getInstance():playEffect("Sounds/Effects/info_down.mp3")
            infoIsDown=true
        end  
    end
    layerTable:runAction(cc.Sequence:create(cc.DelayTime:create(1),  cc.MoveBy:create(.8, cc.p(0, -visibleSize.height*1.05)),cc.CallFunc:create(playEffectDown),cc.MoveBy:create(.2, cc.p(0, visibleSize.height*0.05))))


    local function deleteCallback()
        layerTable:getParent():addChild(countDown(startGame))
        layerTable:removeFromParent(true)
    end
        -- handing touch events
    local function onTouchBegan(touch, event)
        if infoIsDown then
            layerTable:runAction(cc.Sequence:create(cc.MoveBy:create(.2, cc.p(0,-visibleSize.height*.05)), cc.CallFunc:create(playEffectDown),cc.MoveBy:create(.8, cc.p(0,visibleSize.height*1.05)), cc.CallFunc:create(deleteCallback)))
            
        end

        -- CCTOUCHBEGAN event must return true
        return true
    end

    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
    listener:setSwallowTouches(true)

    local eventDispatcher = layerTable:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, layerTable)

    return layerTable
end

function addCallback()
    countNum = countNum -1
    if countNum == 2 then
        num:setString("2")
    elseif countNum == 1 then
        num:setString("1")
    else
        layerCountDown:removeFromParent(true)
        countNum = 3
        startGame()
    end
end

function countDown(startGames)
    math.randomseed(os.time())
    _=math.random();math.random();math.random();



    layerCountDown = cc.Layer:create()
    startGame = startGames
    countNum = 3
    local circle = cc.Sprite:create("Generators/confetti-02.png")
    num = cc.Label:createWithTTF("3", "Fonts/Bariol_Regular.ttf", 230)
    circle:setPosition(visibleSize.width, visibleSize.height*.5)
    circle:setColor(cc.c3b(255, 0, 0))
    circle:setScale(.3)
    layerCountDown:addChild(circle)
    circle:addChild(num)
    --num:setScale(1)
    num:setPosition(circle:getContentSize().width*.5, circle:getContentSize().width*.5)


    circle:runAction(cc.Repeat:create(cc.Sequence:create(cc.MoveTo:create(1, cc.p(visibleSize.width*.15,visibleSize.height*.5)), cc.MoveTo:create(0, cc.p(visibleSize.width, visibleSize.height*.5))), 3))
    circle:runAction(cc.Repeat:create(cc.Sequence:create(cc.ScaleBy:create(.5, 4), cc.ScaleBy:create(.5, .25), cc.CallFunc:create(addCallback)), 3))

    local function onTouchBegan(touch, event)
        -- CCTOUCHBEGAN event must return true
        return true
    end

    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
    listener:setSwallowTouches(true)

    local eventDispatcher = layerCountDown:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, layerCountDown)
    return layerCountDown
end

function loadGameScene(game)
    local loadScene = cc.Scene:createWithExit()
    local layerLoading=cc.LayerColor:create(cc.c4b(107,167,219,255))
    local labelLoading = cc.Label:createWithTTF("Loading...", "Fonts/Bariol_Regular.ttf", 210)
    loadScene:addChild(layerLoading)
    loadScene:addChild(labelLoading)
    labelLoading:setPosition(visibleSize.width*.5, visibleSize.height*.5)

    local function popSceneCallback()
        loadGameEffects = {
            ["Apple"] = function() cc.SimpleAudioEngine:getInstance():preloadEffect("Sounds/Effects/apple/pig_touch.mp3");cc.SimpleAudioEngine:getInstance():preloadEffect("Sounds/Effects/apple/apple_touch.mp3") end,
            ["Milk"] = function() cc.SimpleAudioEngine:getInstance():preloadEffect("Sounds/Effects/milk/cow_touch.mp3") end,
            ["Egg"] = function() cc.SimpleAudioEngine:getInstance():preloadEffect("Sounds/Effects/egg/chicken_touch.mp3") end,
            ["Chocolate"] = function() cc.SimpleAudioEngine:getInstance():preloadEffect("Sounds/Effects/chocolate/bee_click.mp3") end,
            ["Strawberry"] = function() cc.SimpleAudioEngine:getInstance():preloadEffect("Sounds/Effects/strawberry/strawberry_click.mp3") end,
            ["Wheat"] = function() cc.SimpleAudioEngine:getInstance():preloadEffect("Sounds/Effects/wheat/wheat_touch.mp3") end,
        }
        loadGameEffects[game]()
        
        cc.Director:getInstance():popScene()
    end
    loadScene:runAction(cc.Sequence:create(cc.DelayTime:create(1.5),cc.CallFunc:create(popSceneCallback)))
    return loadScene
end





