-- [*] ------------------------------------------------------- dependencies -- ;

local gears = require('gears')

-- [*] ------------------------------------------------------------ methods -- ;

local mouser = function ()
    gears.timer.weak_start_new(0.1, function()
        local c = client.focus
        local cgeometry = c:geometry()
        mouse.coords({ x = cgeometry.x + cgeometry.width/2 , y = cgeometry.y + cgeometry.height/2 })
    end)
end -- [+] relocate mouse after slightly waiting for focus to complete

-- [*] ------------------------------------------------------------- signal -- ;

client.connect_signal("focus", function(c)
    local current_client = mouse.current_client

    if current_client and c ~= current_client then
        mouser()
    end -- [+] no need to relocate the mouse if already over the client
end)


client.connect_signal("unmanage", function(c)
    mouser() 
    --[[
        I think no client check behaviour is better when we
        close things. We can change this later if need be or
        possibly better add a table of classes for
        exclusions.
    --]]
end)


-- [*] ------------------------------------------------------------- export -- ;

return mouser

-- [*] can also manually invoke the function through
-- shortcuts, but this is not necessary with this new
-- version.

-- awful.key({}, 'XF86HomePage', function () 
--   awful.client.run_or_raise(chromium, matcher('Google-chrome')) 
--   mouser() 
-- end),
