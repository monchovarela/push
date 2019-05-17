Info = {}
 
function Info:new()
    -- create group
    local this = display.newGroup()
    -- this is public
    local public = this
    -- create private methods
    local private = {}
    -- import widget inside
    local widget = require("widget")
    --import store
    local store = require "lib.store"
    -- create counter
    local count = 5
    -- load config 
    local config = store.loadTable("storage/config.json",system.ResourceDirectory)
    -- groups
    local btn_settings_group = display.newGroup()
    -- background
    local background = display.newRect(0,0,100,100)
    local back -- back button 
    -- notification
    local notif_bg = display.newRect(0,0,100,100)
    local notif = display.newText("",0,0,"storage/PressStart2P-Regular.ttf",12)
    -- info webview
    local webView = native.newWebView( display.contentCenterX, display.contentCenterY + 45, display.contentWidth, 385 )

    ----------------------------------------------------
    --  Info class private
    ----------------------------------------------------
    function private.Info()

        -- stop all audio files
        audio.stop()

        -- background
        background.x = display.contentCenterX
        background.y = display.contentCenterY
        background.width = 320
        background.height = 480
        background:setFillColor(unpack({2/255,70/255,204/255}))

        -- notification background
        notif_bg.x = display.contentCenterX
        notif_bg.y = 25
        notif_bg.width = 280
        notif_bg.height = 37
        notif_bg:setFillColor(unpack({4/255,57/255,164/255}))

        -- notification
        notif.x = display.contentCenterX
        notif.y = 25
        notif:setFillColor(unpack({0.2,0.8,1}))

        -- btn settings rec
        back = private.createSettingsBtn({
            label = "<-",
            x = 55,
            y = 70,
            onEvent = function(evt)
                if evt.phase == "ended" then
                    private.onButtonBack(evt)
                end
            end
        })  

        webView:request( "storage/info.html", system.ResourceDirectory )

        this:insert(background)
        this:insert(notif_bg)
        this:insert(notif)
        this:insert(btn_settings_group)
        this:insert(webView)

        private.notification(config.info.section_info)

        Runtime:addEventListener("key", private.onBackHardwareKey)
    end

    ----------------------------------------------------
    --  notifications
    ----------------------------------------------------     
    function private.notification(txt)
        notif.text = txt
        timer.performWithDelay(2000,function()
            notif.text = ""
        end)
    end


    --  Simplify btn method settings
    -----------------------------------------
    function private.createSettingsBtn(opts)
        local name = widget.newButton(
            {
                width = 65,
                height = 30,
                label = opts.label or "BACK",
                fontSize = 14,
                font = "storage/PressStart2P-Regular.ttf",
                labelColor = {default = {0.3},over={0}},
                shape = "roundedRect",
                fillColor = {default={109/255,253/255,255/255}, over={39/255,251/255,255/255}},
                strokeColor = {default={109/255,253/255,255/255}, over={39/255,251/255,255/255}},
                strokeWidth = 1,
                cornerRadius = 5,
                onEvent = opts.onEvent
            }
        )
        name.x = opts.x
        name.y = opts.y
        btn_settings_group:insert(name)
        return name
    end


    function private.onButtonBack(event)
        this:dispatchEvent({name="EXIT", target=this})
        this:destroy()
        return true
    end

    function private.onBackHardwareKey(event)
        if event.phase == "up" and event.keyName == "back" then
            private.onButtonBack(event)
            return true
        end
    end

    function public:destroy()
        Runtime:removeEventListener("key", private.onBackHardwareKey)

        background:removeSelf()
        background = nil

        back:removeSelf()
        back = nil

        this:removeSelf()
        this = nil
    end

    -- init main class
    private.Info()
    return this
end
 
return Info