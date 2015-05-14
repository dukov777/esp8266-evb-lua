BFSIZE = 16

tmr.stop(0)
connect_to_router(SSID, PASS)

tmr.alarm(0, 1000, 1, 
    function() 
        ip = wifi.sta.getip()
        if ip ~= nil then 
            log("Connected to " .. ip) 
            if ip ~= nil then
                -- timer is no longer needed
                tmr.stop(0)
                --  connect to mqtt brocker
                m = mqtt.Client(CLIENTID, 120, BRUSER, BRPWD)
                m:on("message", on_message_received)
                m:on("offline", on_mqqt_offline)
                connect_brocker()
            end
        else
            log("Connecting to " .. SSID) 
        end
    end)
