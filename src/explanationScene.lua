require "tableLayer"
require "mapScene"

function preLoadMap1()
    local apple_poster = cc.Sprite:create("Images/Map/apple_poster.png")
    local apple_tree = cc.Sprite:create("Images/Map/apple_tree.png")
    local cat = cc.Sprite:create("Images/Map/cat.png")
    local chicken_1 = cc.Sprite:create("Images/Map/chicken_1.png")
    local chicken_2 = cc.Sprite:create("Images/Map/chicken_2.png")
    local chicken_3 = cc.Sprite:create("Images/Map/chicken_3.png")
    local chocolate_poster = cc.Sprite:create("Images/Map/chocolate_poster.png")
    local chocolate_tree = cc.Sprite:create("Images/Map/chocolate_tree.png")
    local cow = cc.Sprite:create("Images/Map/cow.png")
    local cow_tail = cc.Sprite:create("Images/Map/cow_tail.png")
    cc.SimpleAudioEngine:getInstance():preloadEffect("Sounds/Effects/dog.mp3")
end
function preLoadMap2()
    local cow_tail = cc.Sprite:create("Images/Map/cow_tail.png")
    local dog_body = cc.Sprite:create("Images/Map/dog_body.png")
    local dog_head = cc.Sprite:create("Images/Map/dog_head.png")
    local egg_poster = cc.Sprite:create("Images/Map/egg_poster.png")
    local map_back = cc.Sprite:create("Images/Map/map_back.png")
    local milk_poster = cc.Sprite:create("Images/Map/milk_poster.png")
    local sheep_1 = cc.Sprite:create("Images/Map/sheep_1.png")
    local sheep_2 = cc.Sprite:create("Images/Map/sheep_2.png")
    local stamp_basket = cc.Sprite:create("Images/Map/stamp_basket.png")
    local strawberry_poster = cc.Sprite:create("Images/Map/strawberry_poster.png")
    local strawberry_tree = cc.Sprite:create("Images/Map/strawberry_tree.png")
    cc.SimpleAudioEngine:getInstance():preloadEffect("Sounds/Effects/sheep.mp3")
end
function preLoadMap3()

    local wheat = cc.Sprite:create("Images/Map/wheat.png")
    local wheat_poster = cc.Sprite:create("Images/Map/wheat_poster.png")
    local back = cc.Sprite:create("Images/Table/back.png")
    local stamp_apple_star = cc.Sprite:create("Images/Table/stamp_apple_star.png")
    local stamp_chocolate_star = cc.Sprite:create("Images/Table/stamp_chocolate_star.png")
    local stamp_egg_star = cc.Sprite:create("Images/Table/stamp_egg_star.png")
    local stamp_milk_star = cc.Sprite:create("Images/Table/stamp_milk_star.png")
    local stamp_strawberry_star = cc.Sprite:create("Images/Table/stamp_strawberry_star.png")
    local stamp_wheat_star = cc.Sprite:create("Images/Table/stamp_wheat_star.png")
    local table = cc.Sprite:create("Images/Table/table.png")
end

function explanationView()
    local explanationScene = cc.Scene:createWithExit()
    explanationScene:addChild(createLayerKitchen())
    return explanationScene
end


function createLayerKitchen()
    local layerKitchen = cc.Layer:create()

    -- add in farm background
    local kitchen = cc.Sprite:create("Images/Explanation/Kitchen.png")
    kitchen:setPosition(visibleSize.width / 2, visibleSize.height / 2)
    layerKitchen:addChild(kitchen)

    local boy = cc.Sprite:create("Images/Explanation/boy.png")
    boy:setPosition(visibleSize.width * 0.8, boy:getContentSize().height * 0.25)
    layerKitchen:addChild(boy)

    local medal_bubble = cc.Sprite:create("Images/Explanation/medal_bubble.png")
    medal_bubble:setPosition(visibleSize.width * 0.35, visibleSize.height * 0.6)
    layerKitchen:addChild(medal_bubble)

    local bubble = cc.Sprite:create("Images/Explanation/bubble.png")
    bubble:setPosition(visibleSize.width * 0.35, visibleSize.height * 0.6)
    layerKitchen:addChild(bubble)

    local currentLanguageType = cc.Application:getInstance():getCurrentLanguage()

    local text = "Salut ! Dans quelques heures, un de mes meilleurs amis fêtera son anniversaire et le gâteau que nous attendons n'arrive toujours pas. La voiture est tombée en panne. Il faut absolument que tu nous aides pour faire le meilleur des gâteaux. VEUX-TU ÊTRE NOTRE CHEF?"
    local instruction1 = "Une fois arrivé à la ferme, tu devras obtenir 6 médailles."
    local instruction2 = "Au moment de la préparation du gâteau, nous te souhaitons : BONNE CHANCE !!!"

    if currentLanguageType == cc.LANGUAGE_ENGLISH then
        text = "Salut ! Dans quelques heures, un de mes meilleurs amis fêtera son anniversaire et le gâteau que nous attendons n'arrive toujours pas. La voiture est tombée en panne. Il faut absolument que tu nous aides pour faire le meilleur des gâteaux. VEUX-TU ÊTRE NOTRE CHEF?"
        instruction1 = "Une fois arrivé à la ferme, tu devras obtenir 6 médailles."
        instruction2 = "Au moment de la préparation du gâteau, nous te souhaitons : BONNE CHANCE !!!"
    elseif currentLanguageType == cc.LANGUAGE_SPANISH then
        text = "¡No te lo vas a creer! Estábamos preparando una tarta de cumpleaños para un súper amigo y ¡se nos ha quemado! La fiesta sorpresa es en veinte minutos y todos los invitados están aquí! ¡Te necesitamos!"
        instruction1 = "Una vez entres en la granja tendrás que conseguir las seis medallas"
        instruction2 = "para poder hacer la tarta. ¡Buena suerte!"
    end


    local  label = cc.Label:createWithTTF(text, "Fonts/Bariol_Regular.ttf", 63, cc.rect(0,0,bubble:getContentSize().width*.8,bubble:getContentSize().height*.8))
    label:setColor(cc.c3b(139,198,64))
    label:setPosition(bubble:getContentSize().width * 0.5, bubble:getContentSize().height * 0.5)
    bubble:addChild(label)

    local case = 0
    local stateAction = {
        [1] = function() label:setString(instruction1); preLoadMap1(); end,
        [2] = function() bubble:setVisible(false); preLoadMap2();end,
        [3] = function() bubble:setVisible(true);label:setString(instruction2); preLoadMap3();end,
        [4] = function() mapScene = mapView();cc.Director:getInstance():replaceScene( cc.TransitionFade:create(1, mapScene, cc.c3b(0,0,0)) ); preLoadMap1();end,
        [5] = function() end

    }
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
        case = case +1
        stateAction[case]()
    end

    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
    listener:registerScriptHandler(onTouchMoved,cc.Handler.EVENT_TOUCH_MOVED )
    listener:registerScriptHandler(onTouchEnded,cc.Handler.EVENT_TOUCH_ENDED )
    local eventDispatcher = layerKitchen:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, layerKitchen)

    return layerKitchen
end