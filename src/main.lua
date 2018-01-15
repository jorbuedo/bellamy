cc.FileUtils:getInstance():addSearchPath("src")
cc.FileUtils:getInstance():addSearchPath("res")

-- CC_USE_DEPRECATED_API = true
require "cocos.init"

require "menuScene"

-- cclog
cclog = function(...)
    print(string.format(...))
end


-- for CCLuaEngine traceback
function __G__TRACKBACK__(msg)
    cclog("----------------------------------------")
    cclog("LUA ERROR: " .. tostring(msg) .. "\n")
    cclog(debug.traceback())
    cclog("----------------------------------------")
    return msg
end

local function main()
    collectgarbage("collect")
    -- avoid memory leak
    collectgarbage("setpause", 100)
    collectgarbage("setstepmul", 5000)

    -- initialize director
    local director = cc.Director:getInstance()
    local glview = director:getOpenGLView()
    if nil == glview then
        glview = cc.GLViewImpl:createWithRect("Bellamy", cc.rect(0,0,1024,768))
        director:setOpenGLView(glview)
    end

    glview:setDesignResolutionSize(2048,1536, cc.ResolutionPolicy.FIXED_WIDTH)

    --turn on display FPS
    --director:setDisplayStats(true)

    --set FPS. the default value is 1.0/60 if you don't call this
    director:setAnimationInterval(1.0 / 60)

    --support debug
    local targetPlatform = cc.Application:getInstance():getTargetPlatform()
    if (cc.PLATFORM_OS_IPHONE == targetPlatform) or (cc.PLATFORM_OS_IPAD == targetPlatform) or
       (cc.PLATFORM_OS_ANDROID == targetPlatform) or (cc.PLATFORM_OS_WINDOWS == targetPlatform) or
       (cc.PLATFORM_OS_MAC == targetPlatform) then
        cclog("result is ")
        --require('debugger')()

    end

    function onKeyReleased(keyCode, event)
        if keyCode == cc.KeyCode.KEY_ESCAPE then cc.Director:getInstance():endToLua() end
    end

    function cc.Scene:createWithExit()

        local scene = cc.Scene:create()
        local listener = cc.EventListenerKeyboard:create()
        listener:registerScriptHandler(onKeyReleased,cc.Handler.EVENT_KEYBOARD_RELEASED)
        local eventDispatcher = scene:getEventDispatcher()
        eventDispatcher:addEventListenerWithSceneGraphPriority(listener, scene)
        return scene
    end
    
    visibleSize = cc.Director:getInstance():getVisibleSize()
    resolutionScaleY = 1536/visibleSize.height
    origin = cc.Director:getInstance():getVisibleOrigin()

    stamp_apple_star_won = cc.UserDefault:getInstance():getBoolForKey("stamp_apple_star_won", false)
    stamp_chocolate_star_won = cc.UserDefault:getInstance():getBoolForKey("stamp_chocolate_star_won", false)
    stamp_egg_star_won = cc.UserDefault:getInstance():getBoolForKey("stamp_egg_star_won", false)
    stamp_milk_star_won = cc.UserDefault:getInstance():getBoolForKey("stamp_milk_star_won", false)
    stamp_strawberry_star_won = cc.UserDefault:getInstance():getBoolForKey("stamp_strawberry_star_won", false)
    stamp_wheat_star_won = cc.UserDefault:getInstance():getBoolForKey("stamp_wheat_star_won", false)

    cc.SimpleAudioEngine:getInstance():preloadMusic("Sounds/Music/MainMusic.mp3")
    menuScene = menuView()

    if cc.Director:getInstance():getRunningScene() then
        cc.Director:getInstance():replaceScene(menuScene)
    else
        cc.Director:getInstance():runWithScene(menuScene)
    end
end

local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    error(msg)
end
