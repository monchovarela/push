require "sections.MainClass"

display.setStatusBar( display.HiddenStatusBar ) 

-- activate multitouch if exists
if Runtime:hasEventSource( "multitouch" ) then
    --system.activate( "multitouch" )
end

-- app events
local function onSystemEvent( event )
    if "applicationStart" == event.type then
        system.setIdleTimer( false )
    elseif "applicationSuspend" == event.type then
        system.setIdleTimer( true )
    elseif "applicationResume" == event.type then
        system.setIdleTimer( false )
    elseif "applicationExit" then
        system.setIdleTimer( true )
    end
end



Runtime:addEventListener( "system", onSystemEvent )

local mainClass = MainClass:new()

