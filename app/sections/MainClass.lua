
-- load sections
require "sections.InfoClass"

MainClass = {}
 
function MainClass:new()
    -- create group
    local this = display.newGroup()
    -- this is public
    local public = this
    -- create private methods
    local private = {}
    -- import widget inside
    local widget = require("widget")
    -- import store
    local store = require "lib.store"
    -- create counter
    local count = 4
    -- press timer for btn long press
    local pressTimer
    -- load config 
    local config = store.loadTable("storage/config.json",system.ResourceDirectory)
    -- directory of audio
    local lfs = require ( "lfs" )
    local path = system.pathForFile( "", system.DocumentsDirectory )
    -- background
    local background = display.newRect(0,0,100,100)
    -- groups
    local btn_settings_group = display.newGroup()
    local btn_play_group = display.newGroup()
    -- btn settings vats
    local btn_settings_1,btn_settings_2,btn_settings_3
    -- btn play vars
    local btn_play1,btn_play2,btn_play3,btn_play4,btn_play5,btn_play6
    local btn_del1,btn_del2,btn_del3,btn_del4,btn_del5,btn_del6
    local btn_rec1,btn_rec2,btn_rec3,btn_rec4,btn_rec5,btn_rec6
    local btn_stop1,btn_stop2,btn_stop3,btn_stop4,btn_stop5,btn_stop6
    -- recording
    local recording
    -- notification
    local notif_bg = display.newRect(0,0,100,100)
    local notif = display.newText("",0,0,"storage/PressStart2P-Regular.ttf",12)
    -----------------------------------------
    --  Main class private
    -----------------------------------------
    function private.MainClass()
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
        btn_settings_1 = private.createSettingsBtn({
            label = "Rec",
            x = 55,
            y = 70,
            labelColor = {default = {0.3},over={0}},
            fillColor = {default={255/255,255/255,100/255},over={255/255,255/255,0/255}},
            strokeColor = {default={255/255,255/255,50/255},over={255/255,255/255,0/255}},
            onEvent = private.recMode
        })  
        -- btn settings other 
        btn_settings_2 = private.createSettingsBtn({
            label = "Info",
            x = 162,
            y = 70,
            labelColor = {default = {0.3},over={0}},
            fillColor = {default={113/255,255/255,113/255},over={113/255,255/255,50/255}},
            strokeColor = {default={113/255,255/255,113/255},over={113/255,255/255,50/255}},
            onEvent = private.infoMode
        })
        -- btn settings del
        btn_settings_3 = private.createSettingsBtn({
            label = "Del",
            x = 268,
            y = 70,
            labelColor = {default = {1},over={1}},
            fillColor = {default={255/255,107/255,107/255},over={255/255,107/255,50/255}},
            strokeColor = {default={255/255,107/255,107/255},over={255/255,107/255,50/255}},
            onEvent = private.delMode
        })
         -- play btn
        btn_play1 = private.createPlayBtn(85,160,function(evt) private.playAudioFile(evt,"1",btn_play1) end)
        btn_play2 = private.createPlayBtn(238,160,function(evt) private.playAudioFile(evt,"2",btn_play2) end)
        btn_play3 = private.createPlayBtn(85,285,function(evt) private.playAudioFile(evt,"3",btn_play3) end)
        btn_play4 = private.createPlayBtn(238,285,function(evt) private.playAudioFile(evt,"4",btn_play4) end)
        btn_play5 = private.createPlayBtn(85,410,function(evt) private.playAudioFile(evt,"5",btn_play5) end)
        btn_play6 = private.createPlayBtn(238,410,function(evt) private.playAudioFile(evt,"6",btn_play6) end)
         -- del btn
        btn_del1 = private.createDelBtn(85,160,function(evt) private.deleteAudioFile(evt,"1") end)
        btn_del2 = private.createDelBtn(238,160,function(evt) private.deleteAudioFile(evt,"2") end)
        btn_del3 = private.createDelBtn(85,285,function(evt) private.deleteAudioFile(evt,"3") end)
        btn_del4 = private.createDelBtn(238,285,function(evt) private.deleteAudioFile(evt,"4") end)
        btn_del5 = private.createDelBtn(85,410,function(evt) private.deleteAudioFile(evt,"5") end)
        btn_del6 = private.createDelBtn(238,410,function(evt) private.deleteAudioFile(evt,"6") end)
         -- rec btn
        btn_rec1 = private.createRecBtn(85,160,function(evt) private.recordAudioFile(evt,"1") end)
        btn_rec2 = private.createRecBtn(238,160,function(evt) private.recordAudioFile(evt,"2") end)
        btn_rec3 = private.createRecBtn(85,285,function(evt) private.recordAudioFile(evt,"3") end)
        btn_rec4 = private.createRecBtn(238,285,function(evt) private.recordAudioFile(evt,"4") end)
        btn_rec5 = private.createRecBtn(85,410,function(evt) private.recordAudioFile(evt,"5") end)
        btn_rec6 = private.createRecBtn(238,410,function(evt) private.recordAudioFile(evt,"6") end)
        -- stop rec
        btn_stop1 = private.createStopBtn(85,160,function(evt) private.stopRecAudioFile(evt,"1") end)
        btn_stop2 = private.createStopBtn(238,160,function(evt) private.stopRecAudioFile(evt,"2") end)
        btn_stop3 = private.createStopBtn(85,285,function(evt) private.stopRecAudioFile(evt,"3") end)
        btn_stop4 = private.createStopBtn(238,285,function(evt) private.stopRecAudioFile(evt,"4") end)
        btn_stop5 = private.createStopBtn(85,410,function(evt) private.stopRecAudioFile(evt,"5") end)
        btn_stop6 = private.createStopBtn(238,410,function(evt) private.stopRecAudioFile(evt,"6") end)
        -- insert in group
        this:insert(background)
        this:insert(notif_bg)
        this:insert(notif)
        this:insert(btn_settings_group)
        this:insert(btn_play_group)
    end
    -----------------------------------------
    --  Counter
    -----------------------------------------
    function private.updateTime(obj)
        -- Decrement the number of seconds
        count = count - 1
        -- Update the text object
        obj:setLabel(count)
    end
    -----------------------------------------
    --  notifications
    -----------------------------------------   
    function private.notification(txt)
        notif.text = txt
        timer.performWithDelay(2000,function()
            notif.text = ""
        end)
    end
    -----------------------------------------
    --  Record  audio file method
    -----------------------------------------
    function private.recordAudioFile(evt,name)
        if evt.phase == "began" then
            local filename = "sound_"..name..".wav"
            local filePath = system.pathForFile( filename, system.DocumentsDirectory )
            -- prepare recording
            recording = media.newRecording( filePath )
            -- send notification
            private.notification(config.info.start_recording)
            -- array of btns
            local btnPlay = {btn_play1,btn_play2,btn_play3,btn_play4,btn_play5,btn_play6}
            local btnRec = {btn_rec1,btn_rec2,btn_rec3,btn_rec4,btn_rec5,btn_rec6}
            local btnStop = {btn_stop1,btn_stop2,btn_stop3,btn_stop4,btn_stop5,btn_stop6}
            -- hide show
            btnRec[tonumber(name)].isVisible = false
            btnStop[tonumber(name)].isVisible = true
            -- disable other bottons
            for k, v in pairs(btnRec) do
                v:setEnabled(false)
            end
            -- enable current
            btn_settings_1:setEnabled(false)
            -- enable current
            btnRec[tonumber(name)]:setEnabled(true)
            -- record
            btnStop[tonumber(name)]:setLabel('WAIT')
            timer.performWithDelay( 1000, function()
                -- count 3,2,1
                if count == 1 then
                    btnStop[tonumber(name)]:setLabel('STOP')
                    recording:startRecording()
                    count = 4
                else
                    private.updateTime(btnStop[tonumber(name)])
                end
            end, count )

            return true
        end
    end
    -----------------------------------------
    --  Stop  audio file method
    -----------------------------------------
    function private.stopRecAudioFile(evt,name)
        if evt.phase == "began" then
            private.notification(config.info.stop_recording)
            -- array of btns
            local btnPlay = {btn_play1,btn_play2,btn_play3,btn_play4,btn_play5,btn_play6}
            local btnRec = {btn_rec1,btn_rec2,btn_rec3,btn_rec4,btn_rec5,btn_rec6}
            local btnStop = {btn_stop1,btn_stop2,btn_stop3,btn_stop4,btn_stop5,btn_stop6}
            -- hide show
            btnRec[tonumber(name)].isVisible = true
            btnStop[tonumber(name)].isVisible = false
            -- top recording
            recording:stopRecording()
            -- enable rec settings
            btn_settings_1:setEnabled(true)
            -- wait and enable other btn
            timer.performWithDelay(500,function()
                for k, v in pairs(btnRec) do
                    v:setEnabled(true)
                end
            end)
            return true
        end
    end
    -----------------------------------------
    --  Delete  audio file method
    -----------------------------------------
    function private.deleteAudioFile(evt,name)
        local filename = "sound_"..name..".wav"
        local filename = system.pathForFile(filename,system.DocumentsDirectory)
        if evt.phase == "began" then
            audio.stop()
            audio.dispose(recorded)
            recorded = nil
            return true
        elseif "ended" == evt.phase then
            local s,e = os.remove(filename)
            if s then
                private.notification(config.file.remove)
            else
                private.notification(config.file.not_exists)
            end
            return true
        end
    end
    -----------------------------------------
    --  Play  audio file method
    -----------------------------------------
    function private.playAudioFile(evt,name,obj)
        local phase = evt.phase
        -- create longer press 
        if "began" == phase then

            pressTimer = os.time()

            -- stop this audio
            audio.stop(tonumber(name))

            -- load audio
            local filename = "sound_"..name..".wav"
            recorded = audio.loadStream( filename, system.DocumentsDirectory)

            return true

        elseif "ended" == phase then

            local timeHeld = os.time() - pressTimer
            if timeHeld >= 2 then
                -- check true 
                if recorded then
                    obj:setLabel('LOOP')
                    private.notification(config.info.loop_mode_on)
                    -- loop audio
                    audio.play(recorded,{channel = tonumber(name),loops = -1,onComplete=function(evt)
                        audio.dispose(recorded)
                        recorded = nil
                        obj:setLabel('PLAY')
                    end})
                    private.notification(math.round(audio.getDuration(recorded)/1000).." seg")
                end

            else
                -- check true 
                if recorded then
                    audio.play(recorded,{channel = tonumber(name),onComplete=function(evt)
                        audio.dispose(recorded)
                        recorded = nil
                        obj:setLabel('PLAY')
                    end})
                    private.notification(math.round(audio.getDuration(recorded)/1000).." seg")
                end

            end

            return true
        end  
    end
    -----------------------------------------
    --  Rec Mode method
    -----------------------------------------
    function private.recMode(evt)
        if evt.phase == "began" then
            local arr = {btn_rec1,btn_rec2,btn_rec3,btn_rec4,btn_rec5,btn_rec6}
            for i, v in ipairs(arr) do
                -- check if is visible then disabled other btn
                if v.isVisible then
                    private.notification(config.info.rec_mode_off)
                    btn_settings_2:setEnabled(true)
                    btn_settings_3:setEnabled(true)
                    v.isVisible = false
                else
                    private.notification(config.info.rec_mode_on)
                    btn_settings_2:setEnabled(false)
                    btn_settings_3:setEnabled(false)
                    v.isVisible = true 
                end
            end
            return true
        end
    end
    -----------------------------------------
    --  Del Mode method
    -----------------------------------------
    function private.delMode(evt)
        if evt.phase == "ended" then
            local arr = {btn_del1,btn_del2,btn_del3,btn_del4,btn_del5,btn_del6}
            for i, v in ipairs(arr) do
                -- check if is visible then disabled other btn
                if v.isVisible then
                    private.notification(config.info.del_mode_off)
                    btn_settings_1:setEnabled(true)
                    btn_settings_2:setEnabled(true)
                    v.isVisible = false
                else
                    private.notification(config.info.del_mode_on)
                    btn_settings_1:setEnabled(false)
                    btn_settings_2:setEnabled(false)
                    v.isVisible = true 
                end
            end
            return true
        end
    end
    -----------------------------------------
    --  Info Mode method
    -----------------------------------------
    function private.infoMode(evt)
        if evt.phase == "ended" then
            local info = Info:new()
            private.goTo(info)
            return true
        end
    end
    -----------------------------------------
    --  Simplify btn method settings
    -----------------------------------------
    function private.createSettingsBtn(opts)
        local name = widget.newButton(
            {
                label = opts.label,
                width = 65,
                height = 30,
                fontSize = 12,
                font = "storage/PressStart2P-Regular.ttf",
                labelColor = opts.labelColor or {default = {0.2},over={1}},
                shape = "roundedRect",
                fillColor = opts.fillColor or { default={ 1, 0.2, 0.5, 1 }, over={ 1, 0.2, 0.5, 1 } },
                strokeColor = opts.strokeColor or { default={ 0, 0, 0 }, over={ 0.4, 0.1, 0.2 } },
                strokeWidth = opts.strokeWidth or 2,
                cornerRadius = opts.cornerRadius or 5,
                onEvent = opts.onEvent
            }
        )
        name.x = opts.x
        name.y = opts.y
        btn_settings_group:insert(name)
        return name
    end
    -----------------------------------------
    --  Simplify btn method play
    -----------------------------------------
    function private.createPlayBtn(x,y,listener)
        local name = widget.newButton(
            {
                width = 125,
                height = 107,
                label = "PLAY",
                fontSize = 13,
                font = "storage/PressStart2P-Regular.ttf",
                labelColor = {default = {1},over={0}},
                --shape = "roundedRect",
                fillColor = {default={109/255,253/255,255/255}, over={39/255,251/255,255/255}},
                strokeColor = {default={109/255,253/255,255/255}, over={39/255,251/255,255/255}},
                strokeWidth = 10,
                cornerRadius = 10,
                defaultFile = config.skin.play,
                overFile = config.skin.play_over,
                onEvent = listener
            }
        )
        name.x = x
        name.y = y
        name.isVisible = true
        btn_play_group:insert(name)
        return name
    end
    -----------------------------------------
    --  Simplify btn method rec
    -----------------------------------------
    function private.createRecBtn(x,y,listener)
        local name = widget.newButton(
            {
                width = 125,
                height = 107,
                label = "Rec",
                fontSize = 14,
                font = "storage/PressStart2P-Regular.ttf",
                labelColor = {default = {255/255,107/255,107/255},over={255/255,107/255,107/255}},
                --shape = "roundedRect",
                fillColor = {default={255/255,255/255,100/255},over={255/255,255/255,0/255}},
                strokeColor = {default={255/255,255/255,50/255},over={255/255,255/255,0/255}},
                strokeWidth = 1,
                cornerRadius = 5,
                defaultFile = config.skin.rec,
                overFile = config.skin.rec_over,
                onEvent = listener
            }
        )
        name.x = x
        name.y = y
        name.isVisible = false
        btn_play_group:insert(name)
        return name
    end
    -----------------------------------------
    --  Simplify btn method rec
    -----------------------------------------
    function private.createStopBtn(x,y,listener)
        local name = widget.newButton(
            {
                width = 125,
                height = 107,
                label = "",
                fontSize = 13,
                font = "storage/PressStart2P-Regular.ttf",
                shape = "roundedRect",
                labelColor = {default = {255/255,255/255,100/255},over={255/255,255/255,0/255}},
                fillColor = {default={0/255,45/255,134/255},over={0/255,38/255,113/255}},
                strokeColor = {default={0/255,45/255,134/255},over={0/255,38/255,113/255}},
                strokeWidth = 1,
                cornerRadius = 5,
                onEvent = listener
            }
        )
        name.x = x
        name.y = y
        name.isVisible = false
        btn_play_group:insert(name)
        return name
    end
    -----------------------------------------
    --  Simplify btn method delete
    -----------------------------------------
    function private.createDelBtn(x,y,listener)
        local name = widget.newButton(
            {
                width = 125,
                height = 107,
                label = "DEL",
                fontSize = 13,
                font = "storage/PressStart2P-Regular.ttf",
                labelColor = {default = {1},over={1}},
                fillColor = {default={255/255,107/255,107/255},over={255/255,107/255,50/255}},
                strokeColor = {default={255/255,107/255,107/255},over={255/255,107/255,50/255}},
                --shape = "roundedRect",
                strokeWidth = 1,
                cornerRadius = 5,
                defaultFile = config.skin.del,
                overFile = config.skin.del_over,
                onEvent = listener
            }
        )
        name.x = x
        name.y = y
        name.isVisible = false
        btn_play_group:insert(name)
        return name
    end
    -----------------------------
    --  Section opened
    -----------------------------
    function private.goTo(name)
        name:addEventListener("touch", function() return true end)
        name:addEventListener("tap", function() return true end)

        name:addEventListener("EXIT", function()
            this:remove(name)
            name=nil
        end)

        this:insert(name)
        return true
    end

    -- init main class
    private.MainClass()
    return this
end
 
-- start app
MainClass:new()