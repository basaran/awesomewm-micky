--------------------------------------------------------------> dependencies ;

local gears = require('gears')

-------------------------------------------------------------------> methods ;

local micky = function ()
    gears.timer.weak_start_new(0.05, function()
        local c = client.focus
        local cgeometry = c:geometry()
        
        mouse.coords({ 
            x = cgeometry.x + cgeometry.width / 2,
            y = cgeometry.y + cgeometry.height / 2 
        })
    end)
end
--+ relocate mouse after slightly waiting for focus to
--> complete. you can adjust the timer if you are on a slow
--> cpu to give more time for the client to appear.

---------------------------------------------------------------------> signal ;

client.connect_signal("focus", function(c)
    local focused_client = c
    --+ client the focus is going towards

    gears.timer.weak_start_new(0.05, function()
        local current_client = mouse.current_client

        if not current_client then
            micky() return false
        end
        --+ nothing under the mouse, move directly

        if focused_client ~= current_client then
            micky() return false
        end
        --+ no need to relocate the mouse if already over
        --> the client.
    end)
    --+ mouse.current_client would point to the previous
    --> client without the callback.
end)


client.connect_signal("unmanage", function(c)
    local current_client = mouse.current_client

    if current_client and c ~= current_client then
        micky()
    end 
    --+ no need for the callback here.
end)

---------------------------------------------------------------------> export ;

return micky

--+ can also manually invoke the function through
--> shortcuts, but this is not necessary with this new
--> version.

-- awful.key({}, 'XF86HomePage', function () 
--   awful.client.run_or_raise(chromium, matcher('Google-chrome')) 
--   mouser() 
-- end),
-- naughty.notify({text=current_client.name})
-- naughty.notify({text=focused_client.name})
